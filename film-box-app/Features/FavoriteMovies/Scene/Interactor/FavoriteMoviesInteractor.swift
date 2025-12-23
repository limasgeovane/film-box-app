protocol FavoriteMoviesInteractorLogic {
    func requestFavoriteMovies()
}

final class FavoriteMoviesInteractor {
    weak var presenter: FavoriteMoviesPresenterOutputLogic?
    
    private let repository: FavoriteMoviesRepositoryLogic
    
    init(repository: FavoriteMoviesRepositoryLogic) {
        self.repository = repository
    }
    
    private func fetchFavoriteMovies() {
        let favoritesMovies = repository.getFavorites()
        
        if favoritesMovies.isEmpty {
            presenter?.didRequestFavoriteMoviesEmpty()
        } else {
            presenter?.didRequestFavoriteMovies(favoriteMovies: favoritesMovies)
        }
    }
}

extension FavoriteMoviesInteractor: FavoriteMoviesInteractorLogic {
    func requestFavoriteMovies() {
        fetchFavoriteMovies()
    }
}
