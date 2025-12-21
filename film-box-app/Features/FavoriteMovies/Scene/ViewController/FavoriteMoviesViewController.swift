import UIKit

class FavoriteMoviesViewController: UIViewController {
    private let contentView: FavoriteMoviesViewLogic
    
    init(contentView: FavoriteMoviesViewLogic) {
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
        contentView.favoriteMovies = makeDisplayModels()
    }
    
    private func makeMoviesMock() -> [FavoriteMovies] {
        return (1...4).map { index in
            FavoriteMovies(
                posterImageName: "no-image",
                originalTitle: "Movie Title \(index)",
                voteAverage: Double(index),
                overview: "This is a mock overview for movie number \(index). It exists only to test scrolling, line wrapping and cell height behavior in the Movies screen"
            )
        }
    }
    
    private func makeDisplayModels() -> [FavoriteMoviesDisplayModel] {
        makeMoviesMock().map { FavoriteMoviesDisplayModel(favoriteMovies: $0) }
    }
}
