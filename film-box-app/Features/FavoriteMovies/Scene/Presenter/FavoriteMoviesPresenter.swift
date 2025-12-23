import Foundation

protocol FavoriteMoviesPresenterInputLogic {
    func requestFavoriteMovies()
}

protocol FavoriteMoviesPresenterOutputLogic: AnyObject {
    func didRequestFavoriteMovies(favoriteMovies: [FavoriteMoviesDisplayModel])
    func didRequestFavoriteMoviesEmpty()
}

final class FavoriteMoviesPresenter {
    weak var viewController: FavoriteMoviesViewControllerLogic?
    
    var interactor: FavoriteMoviesInteractorLogic
    
    init(interactor: FavoriteMoviesInteractorLogic) {
        self.interactor = interactor
    }
}

extension FavoriteMoviesPresenter: FavoriteMoviesPresenterInputLogic {
    func requestFavoriteMovies() {
        viewController?.displayLoading()
        interactor.requestFavoriteMovies()
    }
}

extension FavoriteMoviesPresenter: FavoriteMoviesPresenterOutputLogic {
    func didRequestFavoriteMovies(favoriteMovies: [FavoriteMoviesDisplayModel]) {
        viewController?.displayContent(viewModel: favoriteMovies)
    }
    
    func didRequestFavoriteMoviesEmpty() {
        viewController?.displayEmptyState()
    }
}
