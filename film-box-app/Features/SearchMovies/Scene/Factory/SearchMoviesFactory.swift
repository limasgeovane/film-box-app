import UIKit

enum SearchMoviesFactory {
    static func make() -> UIViewController {
        let router = SearchMoviesRouter()
        let presenter = SearchMoviesPresenter()
        let interactor = SearchMoviesInteractor(
            repository: SearchMoviesRepository(),
            presenter: presenter
        )
        let viewController = SearchMoviesViewController(
            interactor: interactor,
            router: router,
            contentView: SearchMoviesView()
        )
        
        presenter.display = viewController
        router.viewController = viewController
        
        return viewController
    }
}
