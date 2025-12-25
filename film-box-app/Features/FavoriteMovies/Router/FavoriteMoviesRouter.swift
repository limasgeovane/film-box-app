import UIKit

protocol FavoriteMoviesRouterLogic {
    func openMovieDetails(movieId: Int)
}

final class FavoriteMoviesRouter: FavoriteMoviesRouterLogic {
    weak var viewController: UIViewController?

    func openMovieDetails(movieId: Int) {
        let movieDetailsViewController = MovieDetailsFactory.make(movieId: movieId)
        viewController?.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}
