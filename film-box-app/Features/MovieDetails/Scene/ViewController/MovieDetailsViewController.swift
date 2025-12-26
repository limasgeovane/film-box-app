import UIKit

protocol MovieDetailsViewControllerLogic: AnyObject {
    func displayLoading()
    func displayContent(displayModel: MovieDetailsDisplayModel)
    func displayError()
}

final class MovieDetailsViewController: UIViewController {
    private let presenter: MovieDetailsPresenterInputLogic
    private let contentView: MovieDetailsViewLogic
    private let movieId: Int
    
    init(
        presenter: MovieDetailsPresenterInputLogic,
        contentView: MovieDetailsViewLogic,
        movieId: Int
    ) {
        self.presenter = presenter
        self.contentView = contentView
        self.movieId = movieId
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
        presenter.requestMovieDetails(movieId: movieId)
    }
}

extension MovieDetailsViewController: MovieDetailsViewControllerLogic {
    func displayLoading() {
        navigationItem.rightBarButtonItem = nil
        contentView.changeState(state: .loading)
    }
    
    func displayContent(displayModel: MovieDetailsDisplayModel) {
        contentView.setupContent(displayModel: displayModel)
        contentView.changeState(state: .content)
    }
    
    func displayError() {
        navigationItem.rightBarButtonItem = nil
        contentView.changeState(state: .error)
    }
}
