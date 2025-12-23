import UIKit

protocol SearchMoviesRouterLogic {
    func popMovies()
}

final class SearchMoviesRouter: SearchMoviesRouterLogic {
    weak var viewController: UIViewController?
    
    func popMovies() {
        viewController?.navigationController?.popViewController(animated: false)
    }
}
