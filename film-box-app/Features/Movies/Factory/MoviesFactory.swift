import UIKit

enum MoviesFactory {
    static func make(movies: [MovieDisplayModel] = []) -> UIViewController {
        let router = MoviesRouter()
        let viewController = MoviesViewController(
            contentView: MoviesView(),
            router: router,
            movies: movies
        )
        
        router.viewController = viewController
    
        return viewController
    }
}
