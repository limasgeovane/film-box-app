import Foundation

protocol SearchMoviesPresenterLogic: AnyObject {
    func didFetchMovies(result: Result<[MovieEntity], Error>)
}

final class SearchMoviesPresenter: SearchMoviesPresenterLogic {
    weak var viewController: SearchMoviesViewControllerLogic?
    var interactor: SearchMoviesInteractorLogic?
    var router: SearchMoviesRouterLogic?
    
    func searchMovies(query: String) {
        viewController?.displayLoading()
        interactor?.requestSearchMovies(query: query)
    }
    
    func didFetchMovies(result: Result<[MovieEntity], Error>) {
        switch result {
        case .success(let movies):
            viewController?.displayMovies(movies: movies)
            router?.openMovies(movies: movies)
        case .failure:
            viewController?.displayError()
        }
    }
}

