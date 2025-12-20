import UIKit

protocol SearchMoviesViewLogic: UIView {
    func focusSearch()
}

class SearchMoviesView: UIView {
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
    
    private let searchMovieButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(String(localized: "searchMoviesButton"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .primary
        button.layer.cornerRadius = 8
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
    }
    
    private func setupViewAttributes() {
        backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            searchMovieStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchMovieStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchMovieStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchMovieStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            searchMovieTextField.heightAnchor.constraint(equalToConstant: 48),
            searchMovieButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

extension SearchMoviesView: SearchMoviesViewLogic {
    func focusSearch() {
        searchMovieButton.becomeFirstResponder()
    }
}
