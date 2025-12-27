import Foundation

protocol MoviesPresenterInputLogic {
    func searchMovies()
    func didTapSearch()
    func didSelectMovie(movieId: Int)
    func didTapFavorite(movieId: Int, isFavorite: Bool)
}

protocol MoviesPresenterOutputLogic: AnyObject {
    func didSearchMovies(movies: [MovieEntity], favoriteMovies: Set<Int>)
    func didSearchMoviesEmpty()
    func didSearchMoviesError()
}

final class MoviesPresenter {
    weak var viewController: MoviesViewControllerLogic?
    
    private var displayModel: [MovieDisplayModel] = []
    
    private let interactor: MoviesInteractorLogic
    private let router: MoviesRouterLogic

    init(
        interactor: MoviesInteractorLogic,
        router: MoviesRouterLogic
    ) {
        self.interactor = interactor
        self.router = router
    }
}

extension MoviesPresenter: MoviesPresenterInputLogic {
    func searchMovies() {
        viewController?.displayLoading()
        interactor.requestSearchMovies()
    }
    
    func didTapSearch() {
        router.openSearchMovies()
    }
    
    func didSelectMovie(movieId: Int) {
        router.openMovieDetails(movieId: movieId)
    }
    
    func didTapFavorite(movieId: Int, isFavorite: Bool) {
        guard let movie = displayModel.first(where: { $0.id == movieId }) else { return }
        
        if isFavorite {
            interactor.favoriteMovie(movie: movie)
        } else {
            interactor.unfavoriteMovie(movieId: movieId)
        }
    }
}

extension MoviesPresenter: MoviesPresenterOutputLogic {
    func didSearchMovies(movies: [MovieEntity], favoriteMovies: Set<Int>) {
        displayModel = movies.map { movie in
            return MovieDisplayModel(
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
                }(),
                isFavorite: favoriteMovies.contains(movie.id)
            )
        }
        
        viewController?.displayContent(movies: displayModel)
    }
    
    func didSearchMoviesEmpty() {
        viewController?.displayEmptyView()
    }
    
    func didSearchMoviesError() {
        viewController?.displayError()
    }
}
