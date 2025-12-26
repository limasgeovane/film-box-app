import XCTest
@testable import film_box_app

final class MoviesRouterTests: XCTestCase {
    var sut: MoviesRouter!
    var navigationControllerSpy: NavigationControllerSpy!
    var rootViewController: UIViewController!
    
    override func setUp() {
        super.setUp()
        sut = MoviesRouter()
        navigationControllerSpy = NavigationControllerSpy()
        rootViewController = UIViewController()
        navigationControllerSpy.viewControllers = [rootViewController]
        sut.viewController = rootViewController
    }
    
    func test_openSearchMovies_shouldPushSearchMoviesViewController() {
        sut.openSearchMovies()
        
        XCTAssertEqual(navigationControllerSpy.pushViewControllerCount, 1)
        XCTAssertTrue(navigationControllerSpy.pushedViewController is SearchMoviesViewController)
        XCTAssertEqual(navigationControllerSpy.pushViewControllerAnimated, true)
    }
    
    func test_openMovieDetails_shouldPushMovieDetailsViewController() {
        sut.openMovieDetails(movieId: 42)
        
        XCTAssertEqual(navigationControllerSpy.pushViewControllerCount, 1)
        XCTAssertTrue(navigationControllerSpy.pushedViewController is MovieDetailsViewController)
        XCTAssertEqual(navigationControllerSpy.pushViewControllerAnimated, true)
    }
}
