import UIKit

protocol FavoriteMoviesViewControllerLogic: AnyObject {
    func displayLoading()
    func displayContent(viewModel: [FavoriteMoviesDisplayModel])
    func displayError()
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
    
    func displayContent(viewModel: [FavoriteMoviesDisplayModel]) {
        contentView.favoriteMovies = viewModel
        contentView.changeState(state: .content)
    }
    
    func displayError() {
        contentView.favoriteMovies = []
        contentView.changeState(state: .error)
    }
    
    func displayEmptyState() {
        contentView.favoriteMovies = []
        contentView.changeState(state: .empty)
    }
}
