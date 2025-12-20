import UIKit

enum FavoriteMoviesFactory {
    static func make() -> UIViewController {
        let viewControler = FavoriteMoviesViewController(contentView: FavoriteMoviesView())
        return viewControler
    }
}
