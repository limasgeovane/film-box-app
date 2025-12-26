import Foundation

protocol FavoriteMoviesRepositoryLogic {
    func favorite(movieId: Int)
    func unfavorite(movieId: Int)
    func getFavoritesIds() -> [Int]
    func isMovieFavorite(id: Int) -> Bool
}

final class FavoriteMoviesRepository: FavoriteMoviesRepositoryLogic {
    func favorite(movieId: Int) {
        var favorites = getFavoritesIds()
        
        if favorites.contains(movieId) == false {
            favorites.append(movieId)
        }
        
        UserDefaults.standard.set(favorites, forKey: Constants.UserDefaults.favoritesMoviesKey)
    }
    
    func unfavorite(movieId: Int) {
        var favorites = getFavoritesIds()
        favorites.removeAll { $0 == movieId }
        
        UserDefaults.standard.set(favorites, forKey: Constants.UserDefaults.favoritesMoviesKey)
    }
    
    func getFavoritesIds() -> [Int] {
        let favorites = UserDefaults.standard.array(forKey: Constants.UserDefaults.favoritesMoviesKey) as? [Int]
        
        if let favorites {
            return favorites.sorted(by: >)
        }
        
        return []
    }
    
    func isMovieFavorite(id: Int) -> Bool {
        return getFavoritesIds().contains(id)
    }
}
