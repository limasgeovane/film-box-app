import UIKit

enum MoviesDetailsFactory {
    static func make() -> UIViewController {
        let viewControler = MovieDetailsViewController(contentView: MovieDetailsView())
        return viewControler
    }
}
