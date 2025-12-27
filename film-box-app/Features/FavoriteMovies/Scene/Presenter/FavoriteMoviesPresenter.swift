import Foundation

protocol FavoriteMoviesPresenterInputLogic {
    func requestFavoriteMovies()
    func didTapUnfavorite(movieId: Int)
    func didSelectFavoriteMovie(movieId: Int)
}

protocol FavoriteMoviesPresenterOutputLogic: AnyObject {
    func didRequestFavoriteMovies(favoriteMovies: [MovieDetailsEntity])
    func didRequestFavoriteMoviesEmpty()
    func didRequestFavoriteMoviesError()
}

final class FavoriteMoviesPresenter {
    weak var viewController: FavoriteMoviesViewControllerLogic?
    
    private var displayModel: [FavoriteMoviesDisplayModel] = []
    
    private let interactor: FavoriteMoviesInteractorLogic
    private let router: FavoriteMoviesRouterLogic
    
    init(
        interactor: FavoriteMoviesInteractorLogic,
        router: FavoriteMoviesRouterLogic
    ) {
        self.interactor = interactor
        self.router = router
    }
}

extension FavoriteMoviesPresenter: FavoriteMoviesPresenterInputLogic {
    func requestFavoriteMovies() {
        viewController?.displayLoading()
        interactor.requestFavoriteMovies()
    }
    
    func didTapUnfavorite(movieId: Int) {
        interactor.unfavoriteMovie(movieId: movieId)
    }
    
    func didSelectFavoriteMovie(movieId: Int) {
        router.openMovieDetails(movieId: movieId)
    }
}

extension FavoriteMoviesPresenter: FavoriteMoviesPresenterOutputLogic {
    func didRequestFavoriteMovies(favoriteMovies: [MovieDetailsEntity]) {
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
    
    func didRequestFavoriteMoviesError() {
        viewController?.displayError()
    }
}
