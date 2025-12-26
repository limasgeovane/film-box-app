import XCTest
@testable import film_box_app

final class MovieDetailsRepositoryTests: XCTestCase {
    let networkSpy = NetworkSpy()
    lazy var sut = MovieDetailsRepository(network: networkSpy)
    
    func test_fetchMovieDetails_givenSuccess_shouldCompleteSuccess() {
        let movieDetails = MovieDetailsEntityFixture.make()
        networkSpy.stubbedResponse = movieDetails
        networkSpy.errorToThrow = nil
        
        sut.fetchMovieDetails(movieId: 42) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.title, movieDetails.title)
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
