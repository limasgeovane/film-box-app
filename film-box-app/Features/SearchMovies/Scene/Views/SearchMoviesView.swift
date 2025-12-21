import UIKit

protocol SearchMoviesViewDelegate: AnyObject {
    func searchPressed(query: String)
}

protocol SearchMoviesViewLogic: UIView {
    var delegate: SearchMoviesViewDelegate? { get set }
    
    func focusSearch()
    func changeState(state: SearchMoviesView.State)
}

class SearchMoviesView: UIView {
    enum State {
        case content
        case loading
        case error
    }
    
    private let searchMovieTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: String(localized: "searchMoviesTextField"),
            attributes: [
                .foregroundColor: UIColor.secondaryLabel,
                .font: .secondary,
            ]
        )
        textField.backgroundColor = .secondarySystemBackground
        textField.font = .secondary
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
        button.backgroundColor = .primary
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
    
    private let errorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let errorImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "xmark.circle.fill")
        image.tintColor = .systemRed
        return image
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .primary
        label.text = "Erro ao buscar filmes"
        label.textColor = .systemRed
        return label
    }()
    
    private lazy var resultStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [errorImage, errorLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    weak var delegate: SearchMoviesViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        setupViewAttributes()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        addSubview(searchMovieStackView)
        addSubview(errorView)
        errorView.addSubview(resultStackView)
    }
    
    private func setupViewAttributes() {
        backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            searchMovieStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            searchMovieStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchMovieStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            searchMovieTextField.heightAnchor.constraint(equalToConstant: 48),
            searchMovieButton.heightAnchor.constraint(equalToConstant: 48),
            
            errorView.topAnchor.constraint(equalTo: searchMovieStackView.bottomAnchor, constant: 16),
            errorView.centerXAnchor.constraint(equalTo: searchMovieStackView.centerXAnchor),
            errorView.widthAnchor.constraint(equalTo: searchMovieStackView.widthAnchor),
            errorView.heightAnchor.constraint(equalToConstant: 48),
            
            resultStackView.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
            resultStackView.centerYAnchor.constraint(equalTo: errorView.centerYAnchor),
            
            errorImage.widthAnchor.constraint(equalToConstant: 24),
            errorImage.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    @objc private func searchButtonPressed() {
        guard let query = searchMovieTextField.text, !query.isEmpty else {
            errorView.isHidden = false
            errorLabel.text = String(localized: "emptyFieldError")
            return
        }
        
        errorView.isHidden = true
        delegate?.searchPressed(query: query)
    }
}

extension SearchMoviesView: SearchMoviesViewLogic {
    func changeState(state: State) {
        switch state {
        case .content:
            loadingView.isHidden = true
            errorView.isHidden = true
        case .loading:
            loadingView.isHidden = false
            errorView.isHidden = true
        case .error:
            loadingView.isHidden = true
            errorView.isHidden = false
        }
    }
    
    func focusSearch() {
        searchMovieTextField.becomeFirstResponder()
    }
}
