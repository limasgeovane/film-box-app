import XCTest
@testable import film_box_app

final class NavigationControllerSpy: UINavigationController {
    private(set) var pushedViewController: UIViewController?
    private(set) var pushViewControllerCount = 0
    private(set) var pushViewControllerAnimated: Bool?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        pushViewControllerCount += 1
        pushViewControllerAnimated = animated
        super.pushViewController(viewController, animated: animated)
    }
    
    private(set) var popViewControllerCount = 0
    private(set) var popViewControllerAnimated: Bool?
    private(set) var poppedViewController: UIViewController?
    
    override func popViewController(animated: Bool) -> UIViewController? {
        popViewControllerCount += 1
        popViewControllerAnimated = animated
        poppedViewController = super.popViewController(animated: animated)
        return poppedViewController
    }
}
