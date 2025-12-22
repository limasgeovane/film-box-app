import UIKit

final class EmptyStateView: UIView {
    private let emptyImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "tray")
        image.tintColor = .systemGray
        return image
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .primary
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var emptyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emptyImage, emptyLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12
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
        addSubview(emptyStackView)
    }
    
    private func setupViewAttributes() {
        backgroundColor = .clear
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            emptyLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, constant: -40),
            
            emptyStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            emptyImage.widthAnchor.constraint(equalToConstant: 48),
            emptyImage.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupMessage(message: String) {
        emptyLabel.text = message
    }
}
