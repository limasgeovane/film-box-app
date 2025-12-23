import UIKit

enum MoviesFactory {
    static func make(movies: [MovieEntity] = []) -> UIViewController {
        let interactor = MoviesInteractor(
            repository: MoviesRepository(),
            favoriteMoviesRepository: FavoriteMoviesRepository(),
            searchMoviesRepository: SearchMoviesRepository()
        )
        
        let router = MoviesRouter()
        let presenter = MoviesPresenter(interactor: interactor, router: router)
        
        let viewController = MoviesViewController(
            presenter: presenter,
            contentView: MoviesView()
        )
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
