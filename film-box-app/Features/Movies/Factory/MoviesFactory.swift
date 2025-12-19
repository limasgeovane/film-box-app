import UIKit

enum MoviesFactory {
    static func make() -> UIViewController {
        let viewControler = MoviesViewController()
        return viewControler
    }
}
