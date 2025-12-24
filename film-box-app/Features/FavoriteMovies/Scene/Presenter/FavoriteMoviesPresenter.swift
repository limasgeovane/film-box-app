import Foundation

protocol FavoriteMoviesPresenterInputLogic {
    func requestFavoriteMovies()
}

protocol FavoriteMoviesPresenterOutputLogic: AnyObject {
    func didRequestFavoriteMovies(favoriteMovies: [MovieEntity])
    func didRequestFavoriteMoviesEmpty()
}

final class FavoriteMoviesPresenter {
    weak var viewController: FavoriteMoviesViewControllerLogic?
    
    private var displayModel: [FavoriteMoviesDisplayModel] = []
    
    var interactor: FavoriteMoviesInteractorLogic
    
    init(interactor: FavoriteMoviesInteractorLogic) {
        self.interactor = interactor
    }
}

extension FavoriteMoviesPresenter: FavoriteMoviesPresenterInputLogic {
    func requestFavoriteMovies() {
        viewController?.displayLoading()
        interactor.requestFavoriteMovies()
    }
}

extension FavoriteMoviesPresenter: FavoriteMoviesPresenterOutputLogic {
    func didRequestFavoriteMovies(favoriteMovies: [MovieEntity]) {
        displayModel = favoriteMovies.map { movie in
            return FavoriteMoviesDisplayModel(
                id: movie.id,
                posterImagePath: {
                    if let posterPath = movie.posterPath, !posterPath.isEmpty {
                        return "\(Constants.TmdbAPI.tmdbImageURL)\(posterPath)"
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
                }()
            )
        }
        
        viewController?.displayContent(displayModel: displayModel)
    }
    
    func didRequestFavoriteMoviesEmpty() {
        viewController?.displayEmptyState()
    }
}
