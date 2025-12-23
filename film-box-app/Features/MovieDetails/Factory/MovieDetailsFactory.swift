import UIKit

enum MovieDetailsFactory {
    static func make(movieId: Int) -> UIViewController {
        let interactor = MovieDetailsInteractor(repository: MovieDetailsRepository())
        let presenter = MovieDetailsPresenter(interactor: interactor)
        
        let viewController = MovieDetailsViewController(
            presenter: presenter,
            contentView: MovieDetailsView(),
            movieId: movieId
        )
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
