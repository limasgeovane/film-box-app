import XCTest
@testable import film_box_app

final class SearchMoviesRouterTests: XCTestCase {
    private var sut: SearchMoviesRouter!
    private var navigationControllerSpy: NavigationControllerSpy!
    private var rootViewController: UIViewController!
    private var pushedViewController: UIViewController!
    
    override func setUp() {
        super.setUp()
        sut = SearchMoviesRouter()
        navigationControllerSpy = NavigationControllerSpy()
        rootViewController = UIViewController()
        pushedViewController = UIViewController()
        
        navigationControllerSpy.viewControllers = [rootViewController, pushedViewController]
        sut.viewController = rootViewController
        rootViewController.navigationController?.setViewControllers([rootViewController, pushedViewController], animated: false)
    }
    
    override func tearDown() {
        sut = nil
        navigationControllerSpy = nil
        rootViewController = nil
        pushedViewController = nil
        super.tearDown()
    }
    
    func test_popMovies_shouldPopViewController() {
        navigationControllerSpy.viewControllers = [rootViewController, pushedViewController]
        rootViewController.navigationController?.setViewControllers([rootViewController, pushedViewController], animated: false)
        
        sut.popMovies()
        
        XCTAssertEqual(navigationControllerSpy.popViewControllerCount, 1)
        XCTAssertEqual(navigationControllerSpy.popViewControllerAnimated, false)
    }
}
