import XCTest
@testable import film_box_app

final class MovieDetailsRepositoryTests: XCTestCase {
    let networkSpy = NetworkSpy()
    
    var sut: MovieDetailsRepository!
    
    override func setUp() {
        super.setUp()
        sut = MovieDetailsRepository(network: networkSpy)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_fetchMovieDetails_givenSuccess_shouldCompleteSuccess() {
        let movieDetailsEntity = MovieDetailsEntity.fixture()
        networkSpy.stubbedResponse = movieDetailsEntity
        networkSpy.errorToThrow = nil
        
        sut.fetchMovieDetails(movieId: 99) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.title, movieDetailsEntity.title)
                XCTAssertEqual(self.networkSpy.messages.count, 1)
            case .failure:
                XCTFail("Should be a success")
            }
        }
    }
    
    func test_fetchMovieDetails_givenFailure_shouldCompleteError() {
        networkSpy.errorToThrow = NSError(domain: "test", code: -1)
        networkSpy.stubbedResponse = nil
        
        sut.fetchMovieDetails(movieId: 99) { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(self.networkSpy.messages.count, 1)
            case .success:
                XCTFail("Should be an error")
            }
        }
    }
}
