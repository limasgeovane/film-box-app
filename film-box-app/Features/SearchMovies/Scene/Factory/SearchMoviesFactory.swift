import UIKit

enum SearchMoviesFactory {
    static func make() -> UIViewController {
        let presenter = SearchMoviesPresenter()
        let interactor = SearchMoviesInteractor(
            repository: SearchMoviesRepository(),
            presenter: presenter
        )
        let viewController = SearchMoviesViewController(interactor: interactor, contentView: SearchMoviesView())
        presenter.display = viewController
        
        return viewController
    }
}
