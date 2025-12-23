import Foundation

protocol MoviesPresenterLogic: AnyObject {
    func presentMovies(movies: [MovieEntity])
    func didTapSearch()
    func didSelectMovie(movieId: Int)
    func didTapFavorite(movieId: Int, isFavorite: Bool)
}

final class MoviesPresenter: MoviesPresenterLogic {
    weak var display: MoviesViewControllerLogic?

    private let interactor: MoviesInteractorLogic
    private let router: MoviesRouterLogic

    private var displayModel: [MovieDisplayModel] = []

    init(
        interactor: MoviesInteractorLogic,
        router: MoviesRouterLogic
    ) {
        self.interactor = interactor
        self.router = router
    }

    func presentMovies(movies: [MovieEntity]) {
        let favoritesRepository = FavoriteMoviesRepository()

        displayModel = movies.map { movie in
            let isFavorite = favoritesRepository.isMovieFavorite(id: movie.id)

            return MovieDisplayModel(
                id: movie.id,
                posterImagePath: {
                    if let posterPath = movie.posterPath, !posterPath.isEmpty {
                        return "https://image.tmdb.org/t/p/w780\(posterPath)"
                    }
                    return ""
                }(),
                title: movie.title,
                ratingText: {
                    if let rating = movie.voteAverage, rating > 0 {
                        return "\(String(localized: "movieRating")): \(String(format: "%.1f", rating))"
                    }
                    return String(localized: "unrated")
                }(),
                overview: {
                    if let overview = movie.overview, !overview.isEmpty {
                        return overview
                    }
                    return String(localized: "noOverviewAvailable")
                }(),
                isFavorite: isFavorite
            )
        }

        display?.displayMovies(movies: displayModel)
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
