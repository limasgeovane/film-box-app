import XCTest
@testable import film_box_app

final class FavoriteMoviesRepositoryTests: XCTestCase {
    var sut: FavoriteMoviesRepository!
    
    override func setUp() {
        super.setUp()
        sut = FavoriteMoviesRepository()
        UserDefaults.standard.removeObject(forKey: Constants.UserDefaults.favoritesMoviesKey)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        UserDefaults.standard.removeObject(forKey: Constants.UserDefaults.favoritesMoviesKey)
    }
    
    func test_favorite_givenEmptyFavorites_shouldAddMovieId() {
        sut.favorite(movieId: 1)
        
        let favorites = sut.getFavoritesIds()
        XCTAssertEqual(favorites, [1])
    }
    
    func test_favorite_givenExistingFavorites_shouldNotDuplicateMovieId() {
        sut.favorite(movieId: 1)
        sut.favorite(movieId: 1)
        
        let favorites = sut.getFavoritesIds()
        XCTAssertEqual(favorites.count, 1)
        XCTAssertEqual(favorites.first, 1)
    }
    
    func test_unfavorite_givenExistingMovieId_shouldRemoveMovieId() {
        sut.favorite(movieId: 1)
        sut.favorite(movieId: 2)
        sut.unfavorite(movieId: 1)
        
        let favorites = sut.getFavoritesIds()
        XCTAssertFalse(favorites.contains(1))
        XCTAssertTrue(favorites.contains(2))
    }
    
    func test_getFavoritesIds_givenMultipleIds_shouldReturnSortedDescending() {
        sut.favorite(movieId: 6)
        sut.favorite(movieId: 1)
        sut.favorite(movieId: 3)
        sut.favorite(movieId: 2)
        
        let favorites = sut.getFavoritesIds()
        XCTAssertEqual(favorites, [6, 3, 2, 1])
    }
    
    func test_isMovieFavorite_givenExistingMovieId_shouldReturnTrue() {
        sut.favorite(movieId: 5)
        
        XCTAssertTrue(sut.isMovieFavorite(id: 5))
    }
    
    func test_isMovieFavorite_givenNonExistingMovieId_shouldReturnFalse() {
        sut.favorite(movieId: 10)
        
        XCTAssertFalse(sut.isMovieFavorite(id: 99))
    }
}
