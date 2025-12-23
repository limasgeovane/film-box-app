import UIKit

protocol SearchMoviesRouterLogic {
    func openMovies(movies: [MovieEntity])
}

final class SearchMoviesRouter: SearchMoviesRouterLogic {
    weak var viewController: UIViewController?
    
    func openMovies(movies: [MovieEntity]) {
        let moviesViewController = MoviesFactory.make(movies: movies)
        viewController?.navigationController?.pushViewController(moviesViewController, animated: true)
    }
}
