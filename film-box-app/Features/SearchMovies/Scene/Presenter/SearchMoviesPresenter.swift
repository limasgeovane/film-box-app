import Foundation

protocol SearchMoviesPresenterLogic {
    func responseMovies(movies: [Movie])
    func responseLoading()
    func responseError()
}

final class SearchMoviesPresenter: SearchMoviesPresenterLogic {
    weak var display: SearchMoviesViewControllerLogic?
    
    func responseMovies(movies: [Movie]) {
        let displayModels = movies.map { movie in
            MovieDisplayModel(
                posterImageName: movie.posterPath ?? "",
                title: movie.title,
                ratingText: "\(String(localized: "movieRating")): \(movie.voteAverage)",
                overview: movie.overview
            )
        }
        
        display?.displayMovies(movies: displayModels)
    }
    
    func responseLoading() {
        display?.displayLoading()
    }
    
    func responseError() {
        display?.displayError()
    }
}
