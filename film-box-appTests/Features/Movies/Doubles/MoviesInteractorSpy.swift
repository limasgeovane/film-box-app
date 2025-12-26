@testable import film_box_app
import Foundation

final class MoviesInteractorSpy: MoviesInteractorLogic {
    private(set) var requestMoviesCount = 0

    func requestSearchMovies() {
        requestMoviesCount = 0
    }

    private(set) var requestFavoriteMovieCount = 0

    func favoriteMovie(movie: film_box_app.MovieDisplayModel) {
        requestFavoriteMovieCount = 0
    }

    private(set) var requestUnfavoriteMovieCount = 0

    func unfavoriteMovie(movieId: Int) {
        requestUnfavoriteMovieCount = 0
    }
}
