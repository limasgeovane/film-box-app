import UIKit

protocol SearchMoviesRouterLogic {
    func openMovies()
}

final class SearchMoviesRouter: SearchMoviesRouterLogic {
    weak var viewController: UIViewController?

    func openMovies() {
//        let moviesViewController = MoviesFactory.make()
//        viewController?.navigationController?.pushViewController(moviesViewController, animated: true)
    }
}
