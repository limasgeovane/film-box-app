import UIKit

enum MoviesFactory {
    static func make(movies: [MovieEntity] = []) -> UIViewController {
        let interactor = MoviesInteractor(
            favoriteMoviesRepository: FavoriteMoviesRepository()
        )
        
        let router = MoviesRouter()
        let presenter = MoviesPresenter(interactor: interactor, router: router)
        
        let viewController = MoviesViewController(
            presenter: presenter,
            contentView: MoviesView()
        )
        
        presenter.display = viewController
        router.viewController = viewController
        presenter.presentMovies(movies: movies)
        
        return viewController
    }
}
