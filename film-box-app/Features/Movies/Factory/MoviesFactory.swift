import UIKit

enum MoviesFactory {
    static func make() -> UIViewController {
        let router = MoviesRouter()
        let viewController = MoviesViewController(
            contentView: MoviesView(),
            router: router
        )
        
        router.viewController = viewController
    
        return viewController
    }
}
