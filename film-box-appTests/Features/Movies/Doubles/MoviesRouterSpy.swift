@testable import film_box_app

final class MoviesRouterSpy: MoviesRouterLogic {
    private(set) var openSearchMoviesCount = 0
    func openSearchMovies() {
        openSearchMoviesCount += 1
    }
    
    private(set) var openMovieDetailsCount = 0
    private(set) var openMovieDetailsParameterId: Int?
    func openMovieDetails(movieId: Int) {
        openMovieDetailsCount += 1
        openMovieDetailsParameterId = movieId
    }
}
