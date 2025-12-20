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
        makeMovieDetailsMock()
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
