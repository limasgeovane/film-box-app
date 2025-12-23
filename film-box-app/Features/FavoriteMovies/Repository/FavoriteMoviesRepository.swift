import Foundation

protocol FavoriteMoviesRepositoryLogic {
    func favorite(favoriteMovie: FavoriteMoviesDisplayModel)
    func unfavorite(movieId: Int)
    func getFavorites() -> [FavoriteMoviesDisplayModel]
    func isMovieFavorite(id: Int) -> Bool
}
final class FavoriteMoviesRepository: FavoriteMoviesRepositoryLogic {
    private let favoritesKey = "FavoriteMovies"
    
    func favorite(favoriteMovie: FavoriteMoviesDisplayModel) {
        var favorites = getFavorites()
        
        favorites.append(favoriteMovie)
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(favorites)
            UserDefaults.standard.set(data, forKey: favoritesKey)
        } catch {
            print("Erro ao codificar FavoriteMovies: \(error)")
        }
    }
    
    func unfavorite(movieId: Int) {
        var favorites = getFavorites()
        favorites.removeAll { $0.id == movieId }
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(favorites)
            UserDefaults.standard.set(data, forKey: favoritesKey)
        } catch {
            print("Erro ao codificar FavoriteMovies após remoção: \(error)")
        }
    }
    
    func getFavorites() -> [FavoriteMoviesDisplayModel] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else {
            return []
        }
        
        let decoder = JSONDecoder()
        do {
            let favorites = try decoder.decode([FavoriteMoviesDisplayModel].self, from: data)
            
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
