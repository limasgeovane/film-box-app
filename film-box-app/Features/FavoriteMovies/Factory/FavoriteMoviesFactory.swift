import UIKit

enum FavoriteMoviesFactory {
    static func make() -> UIViewController {
        let repository = FavoriteMoviesRepository()
        
        let interactor = FavoriteMoviesInteractor(
            repository: repository,
            movieDetailsRepository: MovieDetailsRepository()
        )
        
        let router = FavoriteMoviesRouter()
        
        let presenter = FavoriteMoviesPresenter(interactor: interactor, router: router)
        
        let viewController = FavoriteMoviesViewController(
            presenter: presenter,
            contentView: FavoriteMoviesView()
        )
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
