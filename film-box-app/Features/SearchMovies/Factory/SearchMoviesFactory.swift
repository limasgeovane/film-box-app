import UIKit

enum SearchMoviesFactory {
    static func make() -> UIViewController {
        let router = SearchMoviesRouter()
        let presenter = SearchMoviesPresenter()
        let interactor = SearchMoviesInteractor(
            repository: SearchMoviesRepository(),
            presenter: presenter
        )
        let contentView = SearchMoviesView()
        let viewController = SearchMoviesViewController(
            presenter: presenter,
            contentView: contentView
        )

        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = viewController
        
        return viewController
    }
}
