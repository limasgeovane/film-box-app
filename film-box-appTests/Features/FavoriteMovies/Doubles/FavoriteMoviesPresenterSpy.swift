@testable import film_box_app

final class FavoriteMoviesPresenterSpy: FavoriteMoviesPresenterInputLogic, FavoriteMoviesPresenterOutputLogic {
    private(set) var requestFavoriteMoviesCount = 0
    func requestFavoriteMovies() {
        requestFavoriteMoviesCount += 1
    }
    
    private(set) var didTapUnfavoriteCount = 0
    private(set) var didTapUnfavoriteParameter: Int?
    func didTapUnfavorite(movieId: Int) {
        didTapUnfavoriteCount += 1
        didTapUnfavoriteParameter = movieId
    }
    
    private(set) var didSelectFavoriteMovieCount = 0
    private(set) var didSelectFavoriteMovieParameter: Int?
    func didSelectFavoriteMovie(movieId: Int) {
        didSelectFavoriteMovieCount += 1
        didSelectFavoriteMovieParameter = movieId
    }
    
    private(set) var didRequestFavoriteMoviesCount = 0
    private(set) var didRequestFavoriteMoviesParameter: [MovieDetailsEntity] = []
    func didRequestFavoriteMovies(favoriteMovies: [MovieDetailsEntity]) {
        didRequestFavoriteMoviesCount += 1
        didRequestFavoriteMoviesParameter = favoriteMovies
    }
    
    private(set) var didRequestFavoriteMoviesEmptyCount = 0
    func didRequestFavoriteMoviesEmpty() {
        didRequestFavoriteMoviesEmptyCount += 1
    }
    
    private(set) var didRequestFavoriteMoviesErrorCount = 0
    func didRequestFavoriteMoviesError() {
        didRequestFavoriteMoviesErrorCount += 1
    }
}
