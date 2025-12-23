import UIKit

enum FavoriteMoviesFactory {
    static func make() -> UIViewController {
        let interactor = FavoriteMoviesInteractor(repository: FavoriteMoviesRepository())
        
        let presenter = FavoriteMoviesPresenter(interactor: interactor)
        
        let viewController = FavoriteMoviesViewController(
            presenter: presenter,
            contentView: FavoriteMoviesView()
        )
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
