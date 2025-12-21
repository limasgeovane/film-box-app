import UIKit

class MoviesViewController: UIViewController {
    private let contentView: MoviesViewLogic
    
    init(contentView: MoviesViewLogic) {
        self.contentView = contentView
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
        print("Clicou na lupa")
    }
    
    private func makeMoviesMock() -> [Movie] {
        return (1...15).map { index in
            Movie(
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
