import UIKit

enum FavoriteMoviesFactory {
    static func make() -> UIViewController {
        let viewControler = FavoriteMoviesViewController()
        return viewControler
    }
}
