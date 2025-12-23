import Foundation

protocol SearchMoviesPresenterLogic: AnyObject {
    func didFetchMovies(result: Result<[MovieEntity], Error>)
}

final class SearchMoviesPresenter: SearchMoviesPresenterLogic {
    weak var display: SearchMoviesViewControllerLogic?
    
    var interactor: SearchMoviesInteractorLogic
    var router: SearchMoviesRouterLogic
    
    init(
        interactor: SearchMoviesInteractorLogic,
        router: SearchMoviesRouterLogic
    ) {
        self.interactor = interactor
        self.router = router
    }
    
    func searchMovies(query: String) {
        display?.displayLoading()
        interactor.requestSearchMovies(query: query)
    }
    
    func didFetchMovies(result: Result<[MovieEntity], Error>) {
        switch result {
        case .success(let movies):
            display?.displayMovies(movies: movies)
            router.openMovies(movies: movies)
        case .failure:
            display?.displayError()
        }
    }
}

