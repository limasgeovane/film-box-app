import UIKit

protocol SearchMoviesViewControllerLogic: AnyObject {
    func displayLoading()
    func displayMovies(movies: [MovieDisplayModel])
    func displayError()
}

class SearchMoviesViewController: UIViewController {
    private let interactor: SearchMoviesInteractorLogic
    private let contentView: SearchMoviesViewLogic
    
    init(
        interactor: SearchMoviesInteractorLogic,
        contentView: SearchMoviesViewLogic
    ) {
        self.contentView = contentView
        self.interactor = interactor
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
        title = String(localized: "searchMoviesTitle")
        contentView.delegate = self
        setupDismissKeyboard()
        contentView.changeState(state: .content)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.focusSearch()
    }
    
    private func setupDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SearchMoviesViewController: SearchMoviesViewControllerLogic {
    func displayLoading() {
        contentView.changeState(state: .loading)
    }
    
    func displayMovies(movies: [MovieDisplayModel]) {
        contentView.changeState(state: .content)
        let moviesViewController = MoviesFactory.make(movies: movies)
        navigationController?.pushViewController(moviesViewController, animated: true)
    }
    
    func displayError() {
        contentView.changeState(state: .error)
    }
}

extension SearchMoviesViewController: SearchMoviesViewDelegate {
    func searchPressed(query: String) {
        interactor.requestSearchMovies(query: query)
    }
}
