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
        let result = repository.getFavorites()
        
        switch result {
        case .success(let favorites):
            if favorites.isEmpty {
                presenter?.didRequestFavoriteMoviesEmpty()
            } else {
                presenter?.didRequestFavoriteMovies(favoriteMovies: favorites)
            }
            
        case .failure:
            presenter?.didRequestFavoriteMoviesError()
        }
    }

}

extension FavoriteMoviesInteractor: FavoriteMoviesInteractorLogic {
    func requestFavoriteMovies() {
        fetchFavoriteMovies()
    }
}
