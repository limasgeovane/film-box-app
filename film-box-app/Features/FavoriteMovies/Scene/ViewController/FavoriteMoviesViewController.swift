import UIKit

protocol FavoriteMoviesViewControllerLogic: AnyObject {
    func displayLoading()
    func displayFavoriteMovies(viewModel: [FavoriteMoviesDisplayModel])
    func displayEmptyState()
}

class FavoriteMoviesViewController: UIViewController {
    private let interactor: FavoriteMoviesInteractorLogic
    private let contentView: FavoriteMoviesViewLogic
    
    init(interactor: FavoriteMoviesInteractorLogic, contentView: FavoriteMoviesViewLogic) {
        self.interactor = interactor
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.requestFavoriteMovies()
    }
}

extension FavoriteMoviesViewController: FavoriteMoviesViewControllerLogic {
    func displayLoading() {
        navigationItem.rightBarButtonItem = nil
        contentView.changeState(state: .loading)
    }
    
    func displayFavoriteMovies(viewModel: [FavoriteMoviesDisplayModel]) {
        contentView.favoriteMovies = viewModel
        contentView.changeState(state: .content)
    }
    
    func displayEmptyState() {
        contentView.favoriteMovies = []
        contentView.changeState(state: .empty)
    }
}
