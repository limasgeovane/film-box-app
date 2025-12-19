import UIKit

protocol SearchMoviesViewLogic: UIView {
    func focusSearch()
}

class SearchMoviesView: UIView {
    private let search: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: String(localized: "searchMoviesTextField"),
            attributes: [
                .foregroundColor: UIColor.secondaryLabel,
                .font: UIFont.secondary,
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
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(String(localized: "searchMoviesButton"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .primary
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var searchStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [search, button])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupUIConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        addSubview(searchStackView)
    }
    
    private func setupUIConstraints() {
        NSLayoutConstraint.activate([
            searchStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            search.heightAnchor.constraint(equalToConstant: 48),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

extension SearchMoviesView: SearchMoviesViewLogic {
    func focusSearch() {
        search.becomeFirstResponder()
    }
}
