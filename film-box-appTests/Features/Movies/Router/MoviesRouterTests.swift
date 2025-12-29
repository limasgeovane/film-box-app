import XCTest
@testable import film_box_app

final class MoviesRouterTests: XCTestCase {
    private  var sut: MoviesRouter!
    private var navigationControllerSpy: NavigationControllerSpy!
    private var rootViewController: UIViewController!
    
    override func setUp() {
        super.setUp()
        sut = MoviesRouter()
        navigationControllerSpy = NavigationControllerSpy()
        rootViewController = UIViewController()
        navigationControllerSpy.viewControllers = [rootViewController]
        sut.viewController = rootViewController
    }
    
    override func tearDown() {
        sut = nil
        navigationControllerSpy = nil
        rootViewController = nil
        super.tearDown()
    }
    
    func test_openSearchMovies_shouldPushSearchMoviesViewController() {
        sut.openSearchMovies()
        
        XCTAssertEqual(navigationControllerSpy.pushViewControllerCount, 1)
        XCTAssertTrue(navigationControllerSpy.pushedViewController is SearchMoviesViewController)
        XCTAssertEqual(navigationControllerSpy.pushViewControllerAnimated, true)
    }
    
    func test_openMovieDetails_shouldPushMovieDetailsViewController() {
        sut.openMovieDetails(movieId: 99)
        
        XCTAssertEqual(navigationControllerSpy.pushViewControllerCount, 1)
        XCTAssertTrue(navigationControllerSpy.pushedViewController is MovieDetailsViewController)
        XCTAssertEqual(navigationControllerSpy.pushViewControllerAnimated, true)
    }
}
