import UIKit

protocol FavoriteMoviesViewControllerLogic: AnyObject {
    func displayLoading()
    func displayContent(displayModel: [FavoriteMoviesDisplayModel])
    func displayEmptyState()
}

class FavoriteMoviesViewController: UIViewController {
    private let presenter: FavoriteMoviesPresenterInputLogic
    private let contentView: FavoriteMoviesViewLogic
    
    init(
        presenter: FavoriteMoviesPresenterInputLogic,
        contentView: FavoriteMoviesViewLogic
    ) {
        self.presenter = presenter
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.requestFavoriteMovies()
    }
}

extension FavoriteMoviesViewController: FavoriteMoviesViewControllerLogic {
    func displayLoading() {
        navigationItem.rightBarButtonItem = nil
        contentView.changeState(state: .loading)
    }
    
    func displayContent(displayModel: [FavoriteMoviesDisplayModel]) {
        contentView.favoriteMovies = displayModel
        contentView.changeState(state: .content)
    }

    func displayEmptyState() {
        contentView.favoriteMovies = []
        contentView.changeState(state: .empty)
    }
}
