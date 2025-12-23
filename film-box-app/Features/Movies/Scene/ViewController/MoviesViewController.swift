import UIKit

protocol MoviesViewControllerLogic: AnyObject {
    func displayMovies(movies: [MovieDisplayModel])
}

final class MoviesViewController: UIViewController {
    private let presenter: MoviesPresenterLogic
    private let contentView: MoviesViewLogic
    
    private var moviesDisplayModel: [MovieDisplayModel] = []
    
    init(
        presenter: MoviesPresenterLogic,
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
        contentView.movies = moviesDisplayModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
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
    func displayMovies(movies: [MovieDisplayModel]) {
        moviesDisplayModel = movies
        contentView.movies = movies
    }
}
