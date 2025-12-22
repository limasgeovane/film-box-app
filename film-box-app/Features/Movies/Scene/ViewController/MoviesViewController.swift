import UIKit

class MoviesViewController: UIViewController {
    private let contentView: MoviesViewLogic
    private let router: MoviesRouterLogic
    private var movies: [MovieDisplayModel]
    
    init(
        contentView: MoviesViewLogic,
        router: MoviesRouterLogic,
        movies: [MovieDisplayModel]
    ) {
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
    func didTapFavorite(movieId: Int) {
        guard let index = movies.firstIndex(where: { $0.id == movieId }) else { return }
        movies[index].isFavorite.toggle()
        
        if let moviesView = contentView as? MoviesView {
            moviesView.reloadMovieCell(index: index)
        }
        
        if movies[index].isFavorite {
            // interactor.favoriteMovie(movieId: movieId)
        } else {
            // interactor.unfavoriteMovie(movieId: movieId)
        }
    }
}
