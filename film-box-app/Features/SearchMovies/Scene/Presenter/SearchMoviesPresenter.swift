import Foundation

protocol SearchMoviesPresenterLogic {
    func responseMovies(movies: [MovieEntity])
    func responseLoading()
    func responseError()
}

final class SearchMoviesPresenter: SearchMoviesPresenterLogic {
    weak var display: SearchMoviesViewControllerLogic?
    
    func responseMovies(movies: [MovieEntity]) {
        display?.displayMovies(movies: movies)
    }
    
    func responseLoading() {
        display?.displayLoading()
    }
    
    func responseError() {
        display?.displayError()
    }
}
