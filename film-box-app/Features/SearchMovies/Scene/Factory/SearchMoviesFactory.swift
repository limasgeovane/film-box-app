import UIKit

enum SearchMoviesFactory {
    static func make() -> UIViewController {
        let viewControler = SearchMoviesViewController(contentView: SearchMoviesView())
        return viewControler
    }
}
