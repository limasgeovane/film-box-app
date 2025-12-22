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
