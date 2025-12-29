import XCTest
@testable import film_box_app

final class SearchMoviesPresenterTests: XCTestCase {
    private var sut: SearchMoviesPresenter!
    private var interactorSpy: SearchMoviesInteractorSpy!
    private var routerSpy: SearchMoviesRouterSpy!
    
    override func setUp() {
        super.setUp()
        interactorSpy = SearchMoviesInteractorSpy()
        routerSpy = SearchMoviesRouterSpy()
        sut = SearchMoviesPresenter(interactor: interactorSpy, router: routerSpy)
    }
    
    override func tearDown() {
        sut = nil
        interactorSpy = nil
        routerSpy = nil
        super.tearDown()
    }
    
    func test_openMovies_shouldCallInteractorAndRouter() {
        sut.openMovies(query: "Movie Title")
        
        XCTAssertEqual(interactorSpy.saveLastMovieSearchCount, 1)
        XCTAssertEqual(interactorSpy.saveLastMovieSearchParameterQuery, "Movie Title")
        XCTAssertEqual(routerSpy.popMoviesCount, 1)
    }
}
