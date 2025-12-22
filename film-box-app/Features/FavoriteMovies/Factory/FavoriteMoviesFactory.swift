import UIKit

enum FavoriteMoviesFactory {
    static func make() -> UIViewController {
        let presenter = FavoriteMoviesPresenter()
        let interactor = FavoriteMoviesInteractor(
            repository: FavoriteMoviesRepository(),
            presenter: presenter
        )
        let viewController = FavoriteMoviesViewController(
            interactor: interactor,
            contentView: FavoriteMoviesView()
        )
        
        presenter.display = viewController
        return viewController
    }
}
