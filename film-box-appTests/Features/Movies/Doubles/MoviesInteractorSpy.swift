@testable import film_box_app

final class MoviesInteractorSpy: MoviesInteractorLogic {
    private(set) var requestMoviesCount = 0
    func requestSearchMovies() {
        requestMoviesCount += 1
    }

    private(set) var requestFavoriteMovieCount = 0
    func favoriteMovie(movie: MovieDisplayModel) {
        requestFavoriteMovieCount += 1
    }

    private(set) var requestUnfavoriteMovieCount = 0
    private(set) var requestUnfavoriteMovieParameterId: Int?
    func unfavoriteMovie(movieId: Int) {
        requestUnfavoriteMovieCount += 1
        requestUnfavoriteMovieParameterId = movieId
    }
}
