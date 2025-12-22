import UIKit

protocol MoviesRouterLogic {
    func openSearchMovies()
    func openMovieDetails(movieId: Int)
}

final class MoviesRouter: MoviesRouterLogic {
    weak var viewController: UIViewController?

    func openSearchMovies() {
        let searchMoviesViewController = SearchMoviesFactory.make()
        viewController?.navigationController?.pushViewController(searchMoviesViewController, animated: true)
    }
    
    func openMovieDetails(movieId: Int) {
        let movieDetailsViewController = MovieDetailsFactory.make(movieId: movieId)
        viewController?.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}
