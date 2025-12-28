import UIKit

final class ErrorView: UIView {
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
        label.textColor = .systemRed
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var errorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [errorImage, errorLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.distribution = .fill
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
        addSubview(errorStackView)
    }
    
    private func setupViewAttributes() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 8
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            errorLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, constant: -40),
            
            errorStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            errorImage.widthAnchor.constraint(equalToConstant: 24),
            errorImage.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setupMessage(message: String) {
        errorLabel.text = message
    }
}

#if DEBUG
extension ErrorView {
    var test_debug_errorLabel: String? { errorLabel.text }
}
#endif
