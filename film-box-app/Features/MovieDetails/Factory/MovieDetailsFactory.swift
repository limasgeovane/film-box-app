import UIKit

enum MoviesDetailsFactory {
    static func make() -> UIViewController {
        let viewController = MovieDetailsViewController(contentView: MovieDetailsView())
        return viewController
    }
}
