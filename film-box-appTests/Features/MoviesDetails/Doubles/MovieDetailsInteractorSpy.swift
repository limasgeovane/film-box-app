@testable import film_box_app
import Foundation

final class MovieDetailsInteractorSpy: MovieDetailsInteractorLogic {
    private(set) var requestMovieDetailsCount = 0
    private(set) var requestMovieDetailsParameterId: Int?
    func requestMovieDetails(movieId: Int) {
        requestMovieDetailsCount += 1
        requestMovieDetailsParameterId = movieId
    }
    
    private(set) var favoriteMovieCount = 0
    private(set) var favoriteMovieParameter: Int?
    func favoriteMovie(movieId: Int) {
        favoriteMovieCount += 1
        favoriteMovieParameter = movieId
    }
    
    private(set) var unfavoriteMovieCount = 0
    private(set) var unfavoriteMovieParameterId: Int?
    func unfavoriteMovie(movieId: Int) {
        unfavoriteMovieCount += 1
        unfavoriteMovieParameterId = movieId
    }
    
    private(set) var isMovieFavoriteCount = 0
    private(set) var isMovieFavoriteParameterInt: Int?
    var stubbedIsMovieFavoriteResult: Bool = false
    func isMovieFavorite(movieId: Int) -> Bool {
        isMovieFavoriteCount += 1
        isMovieFavoriteParameterInt = movieId
        return stubbedIsMovieFavoriteResult
    }
}
