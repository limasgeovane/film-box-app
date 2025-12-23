import UIKit

enum SearchMoviesFactory {
    static func make() -> UIViewController {
        let router = SearchMoviesRouter()
        let interactor = SearchMoviesInteractor(repository: SearchMoviesRepository())
        let presenter = SearchMoviesPresenter(interactor: interactor, router: router)
        
        let viewController = SearchMoviesViewController(
            presenter: presenter,
            contentView: SearchMoviesView()
        )
        
        router.viewController = viewController
        interactor.presenter = presenter
        presenter.display = viewController
        
        return viewController
    }
}
