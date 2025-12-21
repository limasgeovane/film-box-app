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
    
    private let resultView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let resultImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "checkmark.circle.fill")
        return image
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .secondary
        label.text = "Sucesso ao buscar filmes"
        return label
    }()
    
    private lazy var resultStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [resultImage, resultLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
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
        addSubview(resultView)
        resultView.addSubview(resultStackView)
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
            
            resultView.topAnchor.constraint(equalTo: searchMovieStackView.bottomAnchor, constant: 16),
            resultView.centerXAnchor.constraint(equalTo: searchMovieStackView.centerXAnchor),
            resultView.widthAnchor.constraint(equalTo: searchMovieStackView.widthAnchor),
            resultView.heightAnchor.constraint(equalToConstant: 48),
            
            resultStackView.centerXAnchor.constraint(equalTo: resultView.centerXAnchor),
            resultStackView.centerYAnchor.constraint(equalTo: resultView.centerYAnchor),
            
            resultImage.widthAnchor.constraint(equalToConstant: 24),
            resultImage.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}

extension SearchMoviesView: SearchMoviesViewLogic {
    func focusSearch() {
        searchMovieTextField.becomeFirstResponder()
    }
}
