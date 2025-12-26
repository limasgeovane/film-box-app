import UIKit

protocol SearchMoviesViewDelegate: AnyObject {
    func searchPressed(query: String)
}

protocol SearchMoviesViewLogic: UIView {
    var delegate: SearchMoviesViewDelegate? { get set }
    
    func focusSearch()
    func changeState(state: SearchMoviesView.State)
}

final class SearchMoviesView: UIView {
    enum State {
        case loading
        case content
        case error
    }
    
    private let searchMovieTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.attributedPlaceholder = NSAttributedString(
            string: String(localized: "searchMoviesTextField"),
            attributes: [
                .foregroundColor: UIColor.secondaryLabel,
                .font: UIFont.secondaryAppFont
            ]
        )

        textField.backgroundColor = .secondarySystemBackground
        textField.font = UIFont.secondaryAppFont
        textField.textColor = .label
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        return textField
    }()
    
    private lazy var searchMovieButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(String(localized: "searchMoviesButton"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "primaryAppColor")
        button.layer.cornerRadius = 8
        button.addTarget(nil, action: #selector(searchButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchMovieStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchMovieTextField, searchMovieButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    private let loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let errorView: ErrorView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var delegate: SearchMoviesViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        setupViewAttributes()
        setupLayout()
        searchMovieTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        addSubview(searchMovieStackView)
        addSubview(loadingView)
        addSubview(errorView)
    }
    
    private func setupViewAttributes() {
        backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchMovieStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            searchMovieStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchMovieStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            errorView.topAnchor.constraint(equalTo: searchMovieStackView.bottomAnchor, constant: 16),
            errorView.centerXAnchor.constraint(equalTo: searchMovieStackView.centerXAnchor),
            errorView.widthAnchor.constraint(equalTo: searchMovieStackView.widthAnchor),
            errorView.heightAnchor.constraint(equalToConstant: 64),
            
            searchMovieTextField.heightAnchor.constraint(equalToConstant: 48),
            searchMovieButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    @objc private func searchButtonPressed() {
        guard let query = searchMovieTextField.text, !query.isEmpty else {
            errorView.isHidden = false
            errorView.setupMessage(message: String(localized: "emptyFieldError"))
            return
        }
        
        errorView.isHidden = true
        delegate?.searchPressed(query: query)
    }
}

extension SearchMoviesView: SearchMoviesViewLogic {
    func changeState(state: State) {
        switch state {
        case .loading:
            loadingView.isHidden = false
            errorView.isHidden = true
        case .content:
            loadingView.isHidden = true
            errorView.isHidden = true
        case .error:
            loadingView.isHidden = true
            errorView.isHidden = false
            errorView.setupMessage(message: String(localized: "requestMoviesError"))
        }
    }
    
    func focusSearch() {
        searchMovieTextField.becomeFirstResponder()
    }
}

extension SearchMoviesView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButtonPressed()
        textField.resignFirstResponder()
        return true
    }
}
