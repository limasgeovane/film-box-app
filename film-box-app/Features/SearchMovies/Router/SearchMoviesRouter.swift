import UIKit

protocol SearchMoviesRouterLogic {
    func openMovies(movies: [Movie])
}

final class SearchMoviesRouter: SearchMoviesRouterLogic {
    weak var viewController: UIViewController?
    
    func openMovies(movies: [Movie]) {
        let moviesViewController = MoviesFactory.make(movies: movies)
        viewController?.navigationController?.pushViewController(moviesViewController, animated: true)
    }
}
