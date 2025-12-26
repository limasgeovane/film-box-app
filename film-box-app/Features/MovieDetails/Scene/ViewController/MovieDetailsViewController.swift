import UIKit

protocol MovieDetailsViewControllerLogic: AnyObject {
    func displayLoading()
    func displayContent(displayModel: MovieDetailsDisplayModel)
    func displayError()
}

final class MovieDetailsViewController: UIViewController {
    private var isFavorite = false
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.requestMovieDetails(movieId: movieId)
    }
    
    private func setupFavoriteButton() {
        let image = UIImage(systemName: isFavorite ? "star.fill" : "star")?.withRenderingMode(.alwaysTemplate)
        let button = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(didTapFavorite)
        )
        button.tintColor = UIColor(named: "primaryAppColor")
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func didTapFavorite() {
        isFavorite.toggle()
        setupFavoriteButton()
        
        presenter.didTapFavorite(movieId: movieId, isFavorite: isFavorite)
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
        isFavorite = displayModel.isFavorite
        setupFavoriteButton()
    }
    
    func displayError() {
        navigationItem.rightBarButtonItem = nil
        contentView.changeState(state: .error)
    }
}
