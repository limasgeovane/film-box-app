import UIKit

enum MoviesFactory {
    static func make(movies: [MovieDisplayModel] = []) -> UIViewController {
        let interactor = MoviesInteractor(
            movies: movies,
            favoriteMoviesRepository: FavoriteMoviesRepository()
        )
        let router = MoviesRouter()
        let viewController = MoviesViewController(
            interactor: interactor,
            contentView: MoviesView(),
            router: router,
            movies: movies
        )
        
        router.viewController = viewController
    
        return viewController
    }
}
