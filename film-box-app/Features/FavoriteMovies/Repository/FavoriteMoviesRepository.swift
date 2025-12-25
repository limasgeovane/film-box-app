import Foundation

protocol FavoriteMoviesRepositoryLogic {
    func favorite(movie: MovieEntity)
    func unfavorite(movieId: Int)
    func getFavorites() -> [MovieEntity]
    func isMovieFavorite(id: Int) -> Bool
}

final class FavoriteMoviesRepository: FavoriteMoviesRepositoryLogic {
    func favorite(movie: MovieEntity) {
        var favorites = getFavorites()
        favorites.append(movie)
        
        do {
            let data = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(data, forKey: Constants.UserDefaults.favoritesMoviesKey)
        } catch {
            print("Erro ao codificar FavoriteMovies: \(error)")
        }
    }
    
    func unfavorite(movieId: Int) {
        var favorites = getFavorites()
        favorites.removeAll { $0.id == movieId }
        
        do {
            let data = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(data, forKey:  Constants.UserDefaults.favoritesMoviesKey)
        } catch {
            print("Erro ao codificar FavoriteMovies após remoção: \(error)")
        }
    }
    
    func getFavorites() -> [MovieEntity] {
        guard let data = UserDefaults.standard.data(forKey:  Constants.UserDefaults.favoritesMoviesKey) else {
            return []
        }
        
        do {
            let favorites = try JSONDecoder().decode([MovieEntity].self, from: data)
            return favorites.sorted { $0.id > $1.id }
        } catch {
            return []
        }
    }
    
    func isMovieFavorite(id: Int) -> Bool {
        return getFavorites().contains {
            $0.id == id
        }
    }
}
