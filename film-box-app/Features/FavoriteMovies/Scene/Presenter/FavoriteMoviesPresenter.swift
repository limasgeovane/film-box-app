import Foundation

protocol FavoriteMoviesPresenterLogic {
    func responseFavoriteMovies(favoriteMovies: [FavoriteMoviesDisplayModel])
    func responseLoading()
    func responseEmptyState()
}

final class FavoriteMoviesPresenter: FavoriteMoviesPresenterLogic {
    weak var display: FavoriteMoviesViewControllerLogic?
    
    func responseFavoriteMovies(favoriteMovies: [FavoriteMoviesDisplayModel]) {
        display?.displayFavoriteMovies(viewModel: favoriteMovies)
    }
    
    func responseLoading() {
        display?.displayLoading()
    }
    
    func responseEmptyState() {
        display?.displayEmptyState()
    }
}
