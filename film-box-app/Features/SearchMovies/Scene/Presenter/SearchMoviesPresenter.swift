import Foundation

protocol SearchMoviesPresenterInputLogic {
    func searchMovies(query: String)
}

protocol SearchMoviesPresenterOutputLogic: AnyObject {
    func didSearchMovies(movies: [MovieEntity])
    func didSearchMoviesError()
}

final class SearchMoviesPresenter {
    weak var viewController: SearchMoviesViewControllerLogic?
    
    var interactor: SearchMoviesInteractorLogic
    var router: SearchMoviesRouterLogic
    
    init(
        interactor: SearchMoviesInteractorLogic,
        router: SearchMoviesRouterLogic
    ) {
        self.interactor = interactor
        self.router = router
    }
}

extension SearchMoviesPresenter: SearchMoviesPresenterInputLogic {
    func searchMovies(query: String) {
        viewController?.displayLoading()
        interactor.requestSearchMovies(query: query)
    }
}

extension SearchMoviesPresenter: SearchMoviesPresenterOutputLogic {
    func didSearchMovies(movies: [MovieEntity]) {
        viewController?.displayContent()
        router.openMovies(movies: movies)
    }
    
    func didSearchMoviesError() {
        viewController?.displayError()
    }
}
