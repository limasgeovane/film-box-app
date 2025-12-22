protocol FavoriteMoviesInteractorLogic {
    func requestFavoriteMovies()
}

final class FavoriteMoviesInteractor: FavoriteMoviesInteractorLogic {
    private let repository: FavoriteMoviesRepositoryLogic
    private let presenter: FavoriteMoviesPresenterLogic
    
    init(
        repository: FavoriteMoviesRepositoryLogic,
        presenter: FavoriteMoviesPresenterLogic
    ) {
        self.repository = repository
        self.presenter = presenter
    }
    
    func requestFavoriteMovies() {
        presenter.responseLoading()
        
        let favorites = repository.getFavorites()
        if favorites.isEmpty {
            presenter.responseEmptyState()
        } else {
            presenter.responseFavoriteMovies(favoriteMovies: favorites)
        }
    }
}
