import XCTest
@testable import film_box_app

final class SearchMoviesRepositoryTests: XCTestCase {
    private var sut: SearchMoviesRepository!
    
    override func setUp() {
        super.setUp()
        sut = SearchMoviesRepository()
        UserDefaults.standard.removeObject(forKey: Constants.UserDefaults.lastSearchKey)
    }
    
    override func tearDown() {
        sut = nil
        UserDefaults.standard.removeObject(forKey: Constants.UserDefaults.lastSearchKey)
        super.tearDown()
    }
    
    func test_saveLastMovieSearch_shouldPersistQueryInUserDefaults() {
        sut.saveLastMovieSearch(query: "Movie Title")
        
        let savedQuery = UserDefaults.standard.string(forKey: Constants.UserDefaults.lastSearchKey)
        XCTAssertEqual(savedQuery, "Movie Title")
    }
}

