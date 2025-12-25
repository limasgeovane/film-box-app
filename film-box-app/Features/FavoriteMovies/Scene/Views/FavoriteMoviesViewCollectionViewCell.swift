import UIKit

protocol FavoriteMoviesViewCollectionViewCellDelegate: AnyObject {
    func didTapUnfavorite(movieId: Int)
}

class FavoriteMoviesViewCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "FavoriteMoviesViewCollectionViewCell"
    
    weak var delegate: FavoriteMoviesViewCollectionViewCellDelegate?
    
    private var movieId: Int?
    
    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "primaryAppColor")
        label.numberOfLines = 0
        label.font = .gridTitle
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemOrange
        label.numberOfLines = 0
        label.font = .gridRating
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.font = .gridOverview
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.tintColor = UIColor(named: "primaryAppColor") ?? .systemBlue
        button.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let textStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        setupLayout()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        contentView.addSubview(cardView)
        cardView.addSubview(posterImageView)
        cardView.addSubview(favoriteButton)
        cardView.addSubview(textStack)
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(ratingLabel)
        textStack.addArrangedSubview(overviewLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            posterImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            posterImageView.widthAnchor.constraint(equalToConstant: 50),
            posterImageView.heightAnchor.constraint(equalToConstant: 75),
            
            favoriteButton.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 4),
            favoriteButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -4),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            
            textStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            textStack.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            textStack.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -4),
            cardView.bottomAnchor.constraint(equalTo: textStack.bottomAnchor, constant: 8)
        ])
        
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        ratingLabel.setContentHuggingPriority(.required, for: .vertical)
        overviewLabel.setContentHuggingPriority(.required, for: .vertical)
        
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        ratingLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        overviewLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let textWidth = textStack.bounds.width
        if textWidth > 0 {
            titleLabel.preferredMaxLayoutWidth = textWidth
            overviewLabel.preferredMaxLayoutWidth = textWidth
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        titleLabel.text = nil
        titleLabel.attributedText = nil
        ratingLabel.text = nil
        overviewLabel.text = nil
        overviewLabel.attributedText = nil
    }
    
    @objc private func favoriteButtonPressed() {
        guard let movieId else { return }
        delegate?.didTapUnfavorite(movieId: movieId)
    }
    
    func configureCell(displayModel: FavoriteMoviesDisplayModel) {
        movieId = displayModel.id
        posterImageView.loadTMDBImage(path: displayModel.posterImagePath)
        titleLabel.setHyphenatedText(displayModel.title)
        ratingLabel.setHyphenatedText(displayModel.ratingText)
        overviewLabel.setHyphenatedText(displayModel.overview)
    }
    
    func fittingHeight(forWidth width: CGFloat) -> CGFloat {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        let targetSize = CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
        let size = contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        return ceil(size.height)
    }
}
