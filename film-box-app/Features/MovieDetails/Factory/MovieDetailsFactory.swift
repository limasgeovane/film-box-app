import UIKit

enum MovieDetailsFactory {
    static func make(movieId: Int) -> UIViewController {
        let presenter = MovieDetailsPresenter()
        let interactor = MovieDetailsInteractor(
            repository: MovieDetailsRepository(),
            presenter: presenter
        )
        let viewController = MovieDetailsViewController(
            movieId: movieId,
            interactor: interactor,
            contentView: MovieDetailsView()
        )
        
        presenter.display = viewController
        
        return viewController
    }
}
