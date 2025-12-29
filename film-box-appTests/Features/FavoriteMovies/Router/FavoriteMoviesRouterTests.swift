import XCTest
@testable import film_box_app

final class FavoriteMoviesRouterTests: XCTestCase {
    var sut: FavoriteMoviesRouter!
    var navigationControllerSpy: NavigationControllerSpy!
    var rootViewController: UIViewController!
    
    override func setUp() {
        super.setUp()
        sut = FavoriteMoviesRouter()
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
    
    func test_openMovieDetails_shouldPushMovieDetailsViewController() {
        sut.openMovieDetails(movieId: 99)
        
        XCTAssertEqual(navigationControllerSpy.pushViewControllerCount, 1)
        XCTAssertTrue(navigationControllerSpy.pushedViewController is MovieDetailsViewController)
        XCTAssertEqual(navigationControllerSpy.pushViewControllerAnimated, true)
    }
}
