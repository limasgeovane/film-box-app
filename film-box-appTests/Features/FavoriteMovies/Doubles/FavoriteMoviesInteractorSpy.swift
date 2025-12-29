@testable import film_box_app

final class FavoriteMoviesInteractorSpy: FavoriteMoviesInteractorLogic {
    private(set) var requestFavoriteMoviesCount = 0
    func requestFavoriteMovies() {
        requestFavoriteMoviesCount += 1
    }
    
    private(set) var requestUnfavoriteMovieCount = 0
    private(set) var requestUnfavoriteMovieParameter: Int?
    func unfavoriteMovie(movieId: Int) {
        requestUnfavoriteMovieCount += 1
        requestUnfavoriteMovieParameter = movieId
    }
}
