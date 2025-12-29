import XCTest
@testable import film_box_app

final class MoviesRepositoryTests: XCTestCase {
    private let networkSpy = NetworkSpy()
    
    private var sut: MoviesRepository!
    
    override func setUp() {
        super.setUp()
        sut = MoviesRepository(network: networkSpy)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_fetchMovies_givenSuccess_shouldCompleteSuccess() {
        let moviesResponseEntity = MoviesResponseEntity.fixture()
        
        networkSpy.stubbedResponse = moviesResponseEntity
        networkSpy.errorToThrow = nil
        
        sut.fetchMovies(query: "Movie Title") { result in
            switch result {
            case .success(let moviesResponse):
                XCTAssertEqual(moviesResponse.results.first?.originalTitle, "Movie Title")
                XCTAssertEqual(self.networkSpy.messages.count, 1)
            case .failure:
                XCTFail("Should be success")
            }
        }
    }
    
    func test_fetchMovies_givenFailure_shouldCompleteError() {
        networkSpy.errorToThrow = NSError(domain: "test", code: -1)
        networkSpy.stubbedResponse = nil
        
        sut.fetchMovies(query: "Movie Title") { result in
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
        UserDefaults.standard.set("Movie Title", forKey: Constants.UserDefaults.lastSearchKey)
        XCTAssertEqual(sut.getLastMovieSearch(), "Movie Title")
    }
}
