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
        case content
        case error
    }
    
    weak var delegate: SearchMoviesViewDelegate?
    
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
    
    private let errorView: ErrorView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        addSubview(errorView)
    }
    
    private func setupViewAttributes() {
        backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
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
        delegate?.searchPressed(query: searchMovieTextField.text ?? "")
    }
}

extension SearchMoviesView: SearchMoviesViewLogic {
    func changeState(state: State) {
        switch state {
        case .content:
            errorView.isHidden = true
        case .error:
            errorView.isHidden = false
            errorView.setupMessage(message: String(localized: "emptyFieldError"))
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

#if DEBUG
extension SearchMoviesView {
    var test_debug_SearchMoviesView_TextField: UITextField { searchMovieTextField }
    var test_debug_SearchMoviesView_testButton: UIButton { searchMovieButton }
    var test_debug_SearchMoviesView_errorView: ErrorView { errorView }
}
#endif
