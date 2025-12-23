import Foundation

protocol FavoriteMoviesRepositoryLogic {
    func favorite(favoriteMovie: FavoriteMoviesDisplayModel)
    func unfavorite(movieId: Int)
    func getFavorites() -> Result<[FavoriteMoviesDisplayModel], Error>
    func isMovieFavorite(id: Int) -> Bool
}
final class FavoriteMoviesRepository: FavoriteMoviesRepositoryLogic {
    private let favoritesKey = "FavoriteMovies"
    
    func favorite(favoriteMovie: FavoriteMoviesDisplayModel) {
        let result = getFavorites()
        
        guard case .success(var favorites) = result else {
            return
        }
        
        if !favorites.contains(where: { $0.id == favoriteMovie.id }) {
            favorites.append(favoriteMovie)
            saveFavorites(favorites)
        }
    }
    
    func unfavorite(movieId: Int) {
        let result = getFavorites()
        
        guard case .success(var favorites) = result else {
            return
        }
        
        favorites.removeAll { $0.id == movieId }
        saveFavorites(favorites)
    }
    
    func getFavorites() -> Result<[FavoriteMoviesDisplayModel], Error> {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else {
            // sucesso técnico, mas lista vazia
            return .success([])
        }
        
        do {
            let favorites = try JSONDecoder().decode([FavoriteMoviesDisplayModel].self, from: data)
            return .success(favorites)
        } catch {
            // erro técnico real
            return .failure(error)
        }
    }
    
    func isMovieFavorite(id: Int) -> Bool {
        let result = getFavorites()
        
        guard case .success(let favorites) = result else {
            return false
        }
        
        return favorites.contains { $0.id == id }
    }
    
    private func saveFavorites(_ favorites: [FavoriteMoviesDisplayModel]) {
        do {
            let data = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(data, forKey: favoritesKey)
        } catch {
            // aqui você pode logar, enviar para analytics, etc
            print("Erro ao codificar FavoriteMovies: \(error)")
        }
    }
}
