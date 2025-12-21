import UIKit

class MovieDetailsViewController: UIViewController {
    private let contentView: MovieDetailsViewLogic
    
    init(contentView: MovieDetailsViewLogic) {
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
        title = String(localized: "movieDetailsTitle")
        setupNavigation()
        makeMovieDetailsMock()
    }
    
    private func setupNavigation() {
        let favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: "star"),
            style: .plain,
            target: self,
            action: #selector(favoriteButtonPressed)
        )
        navigationItem.rightBarButtonItem = favoriteButton
    }
        
    @objc private func favoriteButtonPressed() {
        guard let button = navigationItem.rightBarButtonItem else { return }

        if button.image == UIImage(systemName: "star") {
            button.image = UIImage(systemName: "star.fill")
            button.tintColor = UIColor(named: "primaryColor") ?? .systemBlue
            // interactor.requestFavoriteMovie()
        } else {
            button.image = UIImage(systemName: "star")
            button.tintColor = UIColor.label
            // interactor.requestUnfavoriteMovie()
        }
    }

    private func makeMovieDetailsMock() {
        let displayModel = MovieDetailsDisplayModel(
            backdropPath: "backdrop_path",
            originalTitle: "The Shawshank Redemption",
            title: "Um Sonho de Liberdade",
            overview: "Dois homens presos desenvolvem uma forte amizade ao longo dos anos, encontrando consolo e redenção através de atos de decência comum.",
            releaseDate: "1994-09-23",
            budget: "$25,000,000",
            revenue: "$58,500,000",
            ratingText: "9.3 / 10"
        )
        
        contentView.configureView(displayModel: displayModel)
    }
}
