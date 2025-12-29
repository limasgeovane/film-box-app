import XCTest
@testable import film_box_app

final class SearchMoviesInteractorTests: XCTestCase {
    private var sut: SearchMoviesInteractor!
    private var repositorySpy: SearchMoviesRepositorySpy!
    
    override func setUp() {
        super.setUp()
        repositorySpy = SearchMoviesRepositorySpy()
        sut = SearchMoviesInteractor(repository: repositorySpy)
    }
    
    override func tearDown() {
        sut = nil
        repositorySpy = nil
        super.tearDown()
    }
    
    func test_saveLastMovieSearch_shouldCallRepositoryWithCorrectQuery() {
        sut.saveLastMovieSearch(query: "Movie Title")
        
        XCTAssertEqual(repositorySpy.saveLastMovieSearchCount, 1)
        XCTAssertEqual(repositorySpy.saveLastMovieSearchParameterQuery, "Movie Title")
    }
}
