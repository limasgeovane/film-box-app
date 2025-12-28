import XCTest
@testable import film_box_app

final class NetworkTests: XCTestCase {
    private var requesterSpy: NetworkRequesterSpy!
    private var deserializationSpy: NetworkDeserializationSpy!
    private var sut: Network!
    
    override func setUp() {
        super.setUp()
        requesterSpy = NetworkRequesterSpy()
        deserializationSpy = NetworkDeserializationSpy()
        
        sut = Network(
            networkRequest: requesterSpy,
            networkDeserialization: deserializationSpy
        )
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        requesterSpy = nil
        deserializationSpy = nil
    }
    
    func test_request_successfulDecoding_returnSuccess() {
        let expected = NetworkFixtures.makeResponse()
        
        requesterSpy.stubbedData = try? JSONEncoder().encode(expected)
        deserializationSpy.stubbedDecodedValue = expected
        
        let expectation = self.expectation(description: "Completion called")
        
        sut.request(configuration: NetworkFixtures.RequestConfig()) { (result: Result<NetworkFixtures.Response, Error>) in
            switch result {
            case .success(let model):
                XCTAssertEqual(model, expected)
            case .failure:
                XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_request_requesterFailure_returnFailure() {
        requesterSpy.errorToThrow = NSError(domain: "test", code: 1)
        
        let expectation = self.expectation(description: "Completion called")
        
        sut.request(configuration: NetworkFixtures.RequestConfig()) { (result: Result<NetworkFixtures.Response, Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_request_decodingFailure_returnFailure() {
        requesterSpy.stubbedData = Data()
        deserializationSpy.errorToThrow = NetworkDeserializationError.decodingFailed
        
        let expectation = self.expectation(description: "Completion called")
        
        sut.request(configuration: NetworkFixtures.RequestConfig()) { (result: Result<NetworkFixtures.Response, Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertTrue(error is NetworkDeserializationError)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
