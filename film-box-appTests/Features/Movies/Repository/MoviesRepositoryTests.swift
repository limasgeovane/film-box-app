import XCTest
@testable import film_box_app

final class MoviesRepositoryTests: XCTestCase {
    let networkSpy = NetworkSpy()
    lazy var sut = MoviesRepository(network: networkSpy)
    
    func test_fetchMovies_givenSuccess_shouldCompleteSuccess() {
        let response = MovieEntityFixture.makeResponse()
        networkSpy.stubbedResponse = response
        networkSpy.errorToThrow = nil
        
        sut.fetchMovies(query: "Inception") { result in
            switch result {
            case .success(let moviesResponse):
                XCTAssertEqual(moviesResponse.results.first?.title, "Inception")
                XCTAssertEqual(self.networkSpy.messages.count, 1)
            case .failure:
                XCTFail("Should be success")
            }
        }
    }
    
    func test_fetchMovies_givenFailure_shouldCompleteError() {
        networkSpy.errorToThrow = NSError(domain: "test", code: -1)
        networkSpy.stubbedResponse = nil
        
        sut.fetchMovies(query: "Matrix") { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(self.networkSpy.messages.count, 1)
            case .success:
                XCTFail("Should be error")
            }
        }
    }
    
    func test_getLastMovieSearch_shouldReturnSavedQuery() {
        UserDefaults.standard.set("Batman", forKey: Constants.UserDefaults.lastSearchKey)
        XCTAssertEqual(sut.getLastMovieSearch(), "Batman")
    }
}
