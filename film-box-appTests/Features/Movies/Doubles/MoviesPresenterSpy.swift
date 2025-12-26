import Foundation
@testable import film_box_app

final class MoviesPresenterSpy: MoviesPresenterInputLogic, MoviesPresenterOutputLogic {
    private(set) var searchMoviesCount = 0
    func searchMovies() {
        searchMoviesCount += 1
    }
    
    private(set) var didTapSearchCount = 0
    func didTapSearch() {
        didTapSearchCount += 1
    }
    
    private(set) var didSelectMovieCount = 0
    private(set) var didSelectMovieParameterId: Int?
    func didSelectMovie(movieId: Int) {
        didSelectMovieCount += 1
        didSelectMovieParameterId = movieId
    }
    
    private(set) var didTapFavoriteCount = 0
    private(set) var didTapFavoriteParameterId: Int?
    private(set) var didTapFavoriteParameterIsFavorite: Bool?
    func didTapFavorite(movieId: Int, isFavorite: Bool) {
        didTapFavoriteCount += 1
        didTapFavoriteParameterId = movieId
        didTapFavoriteParameterIsFavorite = isFavorite
    }
    
    private(set) var didSearchMoviesCount = 0
    private(set) var didSearchMoviesParameterMovies: [MovieEntity] = []
    private(set) var didSearchMoviesParameterFavorites: Set<Int> = []
    func didSearchMovies(movies: [MovieEntity], favoriteMovies: Set<Int>) {
        didSearchMoviesCount += 1
        didSearchMoviesParameterMovies = movies
        didSearchMoviesParameterFavorites = favoriteMovies
    }
    
    private(set) var didSearchMoviesEmptyCount = 0
    func didSearchMoviesEmpty() {
        didSearchMoviesEmptyCount += 1
    }
    
    private(set) var didSearchMoviesErrorCount = 0
    func didSearchMoviesError() {
        didSearchMoviesErrorCount += 1
    }
}
