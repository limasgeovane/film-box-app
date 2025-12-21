import UIKit

enum FavoriteMoviesFactory {
    static func make() -> UIViewController {
        let viewController = FavoriteMoviesViewController(contentView: FavoriteMoviesView())
        return viewController
    }
}
