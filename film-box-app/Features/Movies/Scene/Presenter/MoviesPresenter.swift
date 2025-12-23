import Foundation

protocol MoviesPresenterLogic {
    func presentMovies(movies: [MovieEntity])
}

final class MoviesPresenter: MoviesPresenterLogic {
    weak var display: MoviesViewControllerLogic?
    
    func presentMovies(movies: [MovieEntity]) {
        let favoritesRepository = FavoriteMoviesRepository()
        
        let displayModels: [MovieDisplayModel] = movies.map { movie in
            let isFavorite = favoritesRepository.isMovieFavorite(id: movie.id)
            
            return MovieDisplayModel(
                id: movie.id,
                posterImagePath: {
                    if let posterPath = movie.posterPath, !posterPath.isEmpty {
                        return "https://image.tmdb.org/t/p/w780\(posterPath)"
                    } else {
                        return ""
                    }
                }(),
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
}
