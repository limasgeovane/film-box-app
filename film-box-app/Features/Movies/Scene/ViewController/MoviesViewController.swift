import UIKit

protocol MoviesViewControllerLogic: AnyObject {
    func displayLoading()
    func displayEmptyView()
    func displayContent(movies: [MovieDisplayModel])
    func displayError()
}

final class MoviesViewController: UIViewController {
    private let presenter: MoviesPresenterInputLogic
    private let contentView: MoviesViewLogic
    
    init(
        presenter: MoviesPresenterInputLogic,
        contentView: MoviesViewLogic
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
        contentView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.searchMovies()
    }
    
    private func setupNavigation() {
        navigationItem.hidesBackButton = true
        
        let searchButton = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(searchButtonPressed)
        )
        
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc private func searchButtonPressed() {
        presenter.didTapSearch()
    }
}

extension MoviesViewController: MoviesViewDelegate {
    func didSelectMovie(movieId: Int) {
        presenter.didSelectMovie(movieId: movieId)
    }
}

extension MoviesViewController: MovieViewCollectionViewCellDelegate {
    func didTapFavorite(movieId: Int, isFavorite: Bool) {
        presenter.didTapFavorite(movieId: movieId, isFavorite: isFavorite)
    }
}

extension MoviesViewController: MoviesViewControllerLogic {
    func displayLoading() {
        contentView.changeState(state: .loading)
    }
    
    func displayEmptyView() {
        contentView.changeState(state: .Empty)
    }
    
    func displayContent(movies: [MovieDisplayModel]) {
        contentView.movies = movies
        contentView.changeState(state: .content)
    }
    
    func displayError() {
        contentView.changeState(state: .error)
    }
}
