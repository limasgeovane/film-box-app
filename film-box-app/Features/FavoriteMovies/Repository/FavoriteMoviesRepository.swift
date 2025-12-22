import Foundation

protocol FavoriteMoviesRepositoryLogic {
    func favorite(favoriteMovie: FavoriteMoviesDisplayModel)
    func unfavorite(movieId: Int)
    func getFavorites() -> [FavoriteMoviesDisplayModel]
    func isMovieFavorite(id: Int) -> Bool
}

class FavoriteMoviesRepository: FavoriteMoviesRepositoryLogic {
    private let favoritesKey = "FavoriteMovies"
    
    func favorite(favoriteMovie: FavoriteMoviesDisplayModel) {
        var favorites = getFavorites()
        if !favorites.contains(where: { $0.id == favoriteMovie.id }) {
            favorites.append(favoriteMovie)
            saveFavorites(favorites)
        }
    }
    
    func unfavorite(movieId: Int) {
        var favorites = getFavorites()
        favorites.removeAll { $0.id == movieId }
        saveFavorites(favorites)
    }
    
    func getFavorites() -> [FavoriteMoviesDisplayModel] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else {
            return []
        }
        
        do {
            let favorites = try JSONDecoder().decode([FavoriteMoviesDisplayModel].self, from: data)
            return favorites
        } catch {
            print("Erro ao decodificar FavoriteMovies: \(error)")
            return []
        }
    }
    
    func isMovieFavorite(id: Int) -> Bool {
        return getFavorites().contains { $0.id == id }
    }
    
    private func saveFavorites(_ favorites: [FavoriteMoviesDisplayModel]) {
        do {
            let data = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(data, forKey: favoritesKey)
        } catch {
            print("Erro ao codificar FavoriteMovies: \(error)")
        }
    }
}
