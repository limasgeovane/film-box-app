import Foundation

protocol SearchMoviesPresenterLogic {
    func responseMovies(movies: [Movie])
    func responseLoading()
    func responseError()
}

final class SearchMoviesPresenter: SearchMoviesPresenterLogic {
    weak var display: SearchMoviesViewControllerLogic?
    
    func responseMovies(movies: [Movie]) {
        display?.displayMovies(movies: movies)
    }
    
    func responseLoading() {
        display?.displayLoading()
    }
    
    func responseError() {
        display?.displayError()
    }
}
