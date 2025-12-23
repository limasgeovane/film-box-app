import Foundation

protocol SearchMoviesPresenterInputLogic {
    func openMovies(query: String)
}

final class SearchMoviesPresenter: SearchMoviesPresenterInputLogic{
    var interactor: SearchMoviesInteractorLogic
    var router: SearchMoviesRouterLogic
    
    init(
        interactor: SearchMoviesInteractorLogic,
        router: SearchMoviesRouterLogic
    ) {
        self.interactor = interactor
        self.router = router
    }
    
    func openMovies(query: String) {
        interactor.saveLastMovieSearch(query: query)
        router.popMovies()
    }
}
