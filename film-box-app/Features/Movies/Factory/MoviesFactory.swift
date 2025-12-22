import UIKit

enum MoviesFactory {
    static func make(movies: [Movie] = []) -> UIViewController {
        let presenter = MoviesPresenter()
        let interactor = MoviesInteractor(favoriteMoviesRepository: FavoriteMoviesRepository())
        let router = MoviesRouter()
        let viewController = MoviesViewController(
            interactor: interactor,
            presenter: presenter,
            contentView: MoviesView(),
            router: router,
            movies: []
        )
        
        presenter.display = viewController
        router.viewController = viewController
        presenter.presentMovies(movies: movies)
        
        return viewController
    }
}
