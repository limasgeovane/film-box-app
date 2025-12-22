import UIKit

protocol SearchMoviesRouterLogic {
    func openMovies(movies: [MovieDisplayModel])
}

final class SearchMoviesRouter: SearchMoviesRouterLogic {
    weak var viewController: UIViewController?

    func openMovies(movies: [MovieDisplayModel]) {
        let moviesViewController = MoviesFactory.make(movies: movies)
        viewController?.navigationController?.pushViewController(moviesViewController, animated: true)
    }
}
