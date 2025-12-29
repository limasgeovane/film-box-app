@testable import film_box_app

final class FavoriteMoviesRouterSpy: FavoriteMoviesRouterLogic {
    private(set) var openMovieDetailsCount = 0
    private(set) var openMovieDetailsParameter: Int?
    func openMovieDetails(movieId: Int) {
        openMovieDetailsCount += 1
        openMovieDetailsParameter = movieId
    }
}
