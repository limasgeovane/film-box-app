import UIKit

protocol MoviesRouterLogic {
    func openSearchMovies()
}

final class MoviesRouter: MoviesRouterLogic {
    weak var viewController: UIViewController?

    func openSearchMovies() {
        let searchMoviesViewController = SearchMoviesFactory.make()
        viewController?.navigationController?.pushViewController(searchMoviesViewController, animated: true)
    }
}
