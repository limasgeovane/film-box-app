import UIKit

protocol SearchMoviesViewControllerLogic: AnyObject {
    func displayContent()
}

final class SearchMoviesViewController: UIViewController {
    private let presenter: SearchMoviesPresenterInputLogic
    private let contentView: SearchMoviesViewLogic
    
    init(
        presenter: SearchMoviesPresenterInputLogic,
        contentView: SearchMoviesViewLogic
    ) {
        self.presenter = presenter
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
        title = String(localized: "searchMoviesTitle")
        contentView.delegate = self
        setupDismissKeyboard()
        displayContent()
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
    func displayContent() {
        contentView.changeState(state: .content)
    }
}

extension SearchMoviesViewController: SearchMoviesViewDelegate {
    func searchPressed(query: String) {
        if query.isEmpty {
            contentView.changeState(state: .error)
        } else {
            presenter.openMovies(query: query)
        }
    }
}
