import UIKit

protocol MoviesViewControllerLogic: AnyObject {
    func displayMovies(movies: [MovieDisplayModel])
}

class MoviesViewController: UIViewController {
    private let interactor: MoviesInteractorLogic
    private let presenter: MoviesPresenter
    private let contentView: MoviesViewLogic
    private let router: MoviesRouterLogic
    private var movies: [MovieDisplayModel]
    
    init(
        interactor: MoviesInteractorLogic,
        presenter: MoviesPresenter,
        contentView: MoviesViewLogic,
        router: MoviesRouterLogic,
        movies: [MovieDisplayModel]
    ) {
        self.interactor = interactor
        self.presenter = presenter
        self.contentView = contentView
        self.router = router
        self.movies = movies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
        contentView.delegate = self
        contentView.movies = movies
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    private func setupNavigation() {
        self.navigationItem.hidesBackButton = true
        
        let image = UIImage(systemName: "magnifyingglass")
        let searchButton = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(searchButtonPressed)
        )
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc private func searchButtonPressed() {
        router.openSearchMovies()
    }
}

extension MoviesViewController: MoviesViewDelegate {
    func didSelectMovie(movieId: Int) {
        router.openMovieDetails(movieId: movieId)
    }
}

extension MoviesViewController: MovieViewCollectionViewCellDelegate {
    func didTapFavorite(movieId: Int, isFavorite: Bool) {
        guard let index = movies.firstIndex(where: { $0.id == movieId }) else { return }
        
        movies[index].isFavorite = isFavorite
        
        let movie = movies[index]
        if movie.isFavorite {
            interactor.favoriteMovie(movie: movie)
        } else {
            interactor.unfavoriteMovie(movieId: movie.id)
        }
    }
}

extension MoviesViewController: MoviesViewControllerLogic {
    func displayMovies(movies: [MovieDisplayModel]) {
        self.movies = movies
        contentView.movies = movies
    }
}
