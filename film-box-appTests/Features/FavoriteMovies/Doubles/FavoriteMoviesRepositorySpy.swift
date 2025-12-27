@testable import film_box_app

final class FavoriteMoviesRepositorySpy: FavoriteMoviesRepositoryLogic {
    private(set) var favoriteCount = 0
    private(set) var favoriteParameterFavoriteMovie: Int?
    func favorite(movieId movie: Int) {
        favoriteCount += 1
        favoriteParameterFavoriteMovie = movie
    }
    
    private(set) var getFavoritesCount = 0
    var stubbedGetFavoritesResult: [Int] = []
    func getFavoritesIds() -> [Int] {
        getFavoritesCount += 1
        return stubbedGetFavoritesResult
    }
    
    private(set) var unfavoriteCount = 0
    private(set) var unfavoriteParameterFavoriteMovie: Int?
    func unfavorite(movieId: Int) {
        unfavoriteCount += 1
        unfavoriteParameterFavoriteMovie = movieId
    }
    
    private(set) var isMovieFavoriteCount = 0
    private(set) var isMovieFavoriteParameterInt: Int?
    var stubbedIsMovieFavoriteResult: Bool = false
    func isMovieFavorite(id: Int) -> Bool {
        isMovieFavoriteCount += 1
        isMovieFavoriteParameterInt = id
        return stubbedIsMovieFavoriteResult
    }
}
