import UIKit

enum MoviesFactory {
    static func make() -> UIViewController {
        let viewControler = MoviesViewController(contentView: MoviesView())
        return viewControler
    }
}
