import UIKit

class MoviesViewController: UIViewController {
    private let contentView: MoviesViewLogic
    private let router: MoviesRouterLogic
    
    init(contentView: MoviesViewLogic, router: MoviesRouterLogic) {
        self.contentView = contentView
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        contentView.movies = makeDisplayModels()
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
    
    private func makeMoviesMock() -> [Movies] {
        return (1...15).map { index in
            Movies(
                posterImageName: "image-filme-mock",
                originalTitle: "Movie Title \(index)",
                voteAverage: Double(index),
                overview: "This is a mock overview for movie number \(index). It exists only to test scrolling, line wrapping and cell height behavior in the Movies screen"
            )
        }
    }
    
    private func makeDisplayModels() -> [MovieDisplayModel] {
        makeMoviesMock().map { MovieDisplayModel(movie: $0) }
    }
}
