import UIKit

protocol MovieDetailsViewControllerLogic: AnyObject {
    func displayLoading()
    func displayMovieDetails(displayModel: MovieDetailsDisplayModel)
    func displayError()
}

class MovieDetailsViewController: UIViewController {
    private let movieId: Int
    private let interactor: MovieDetailsInteractorLogic
    private let contentView: MovieDetailsViewLogic
    
    private var favoriteButton: UIBarButtonItem?
    
    init(
        movieId: Int,
        interactor: MovieDetailsInteractorLogic,
        contentView: MovieDetailsViewLogic
    ) {
        self.movieId = movieId
        self.interactor = interactor
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
        interactor.requestMovieDetails(movieId: movieId)
    }
    
    private func setupNavigation() {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "star"),
            style: .plain,
            target: self,
            action: #selector(favoriteButtonPressed)
        )
        favoriteButton = button
        navigationItem.rightBarButtonItem = button
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
}

extension MovieDetailsViewController: MovieDetailsViewControllerLogic {
    func displayLoading() {
        navigationItem.rightBarButtonItem = nil
        contentView.changeState(state: .loading)
    }
    
    func displayMovieDetails(displayModel: MovieDetailsDisplayModel) {
        navigationItem.rightBarButtonItem = favoriteButton
        contentView.setupContent(displayModel: displayModel)
        contentView.changeState(state: .content)
    }
    
    func displayError() {
        navigationItem.rightBarButtonItem = nil
        contentView.changeState(state: .error)
    }
    
}
