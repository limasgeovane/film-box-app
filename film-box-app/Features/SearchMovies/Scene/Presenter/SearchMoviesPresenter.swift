import Foundation

protocol SearchMoviesPresenterLogic {
    func responseMovies(movies: [Movie])
    func responseLoading()
    func responseError()
}

final class SearchMoviesPresenter: SearchMoviesPresenterLogic {
    weak var display: SearchMoviesViewControllerLogic?
    
    func responseMovies(movies: [Movie]) {
        let favoritesRepository = FavoriteMoviesRepository()
        
        let displayModels: [MovieDisplayModel] = movies.map { movie in
            let isFavorite = favoritesRepository.isMovieFavorite(id: movie.id)
            
            return MovieDisplayModel(
                id: movie.id,
                posterImageName: movie.posterPath,
                title: movie.title,
                ratingText: {
                    if let rating = movie.voteAverage, rating > 0 {
                        return "\(String(localized: "movieRating")): \(String(format: "%.1f", rating))"
                    } else {
                        return String(localized: "unrated")
                    }
                }(),
                overview: {
                    if let overview = movie.overview, !overview.isEmpty {
                        return overview
                    } else {
                        return String(localized: "noOverviewAvailable")
                    }
                }(),
                isFavorite: isFavorite
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
