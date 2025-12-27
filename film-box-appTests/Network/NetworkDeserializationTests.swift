import Foundation
import XCTest
@testable import film_box_app

private struct DeserializationTestResponse: Codable, Equatable {
    let name: String
}

final class NetworkDeserializationTests: XCTestCase {
    func test_decode_validData_shouldReturnDecodedObject() throws {
        let sut = makeSUT()
        let expected = DeserializationTestResponse(name: "Movie Title")
        let data = try JSONEncoder().encode(expected)
        
        let decoded: DeserializationTestResponse = try sut.decode(data: data)
        
        XCTAssertEqual(decoded.name, expected.name)
    }
    
    func test_decode_nilData_shouldThrowInvalidData() {
        let sut = makeSUT()
        
        XCTAssertThrowsError(try sut.decode(data: nil) as DeserializationTestResponse) { error in
            XCTAssertEqual(error as? NetworkDeserializationError, .invalidData)
        }
    }
    
    func test_decode_invalidJSON_shouldThrowDecodingFailed() {
        let sut = makeSUT()
        let data = Data("invalid json".utf8)
        
        XCTAssertThrowsError(try sut.decode(data: data) as DeserializationTestResponse) { error in
            XCTAssertEqual(error as? NetworkDeserializationError, .decodingFailed)
        }
    }
    
    private func makeSUT() -> NetworkDeserialization {
        NetworkDeserialization()
    }
}
