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
        
        presenter.viewController = viewController
        router.viewController = viewController
        presenter.presentContent(movies: movies)
        
        return viewController
    }
}
