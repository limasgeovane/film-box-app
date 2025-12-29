import UIKit

protocol MovieViewCollectionViewCellDelegate: AnyObject {
    func didTapFavorite(movieId: Int, isFavorite: Bool)
}

protocol MovieViewCollectionViewCellLogic: UIView {
    func configureCell(displayModel: MovieDisplayModel)
}

final class MovieViewCollectionViewCell: UICollectionViewCell, MovieViewCollectionViewCellLogic {
    static let identifier: String = "MovieViewCollectionViewCell"
    
    weak var delegate: MovieViewCollectionViewCellDelegate?
    
    private var movieId: Int?
    private var isFavorite: Bool = false
    
    private let movieCardView: UIView = {
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
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .systemGray
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
        setupViewAttributes()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        contentView.addSubview(movieCardView)
        movieCardView.addSubview(posterImageView)
        movieCardView.addSubview(favoriteButton)
        movieCardView.addSubview(textStack)
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(ratingLabel)
        textStack.addArrangedSubview(overviewLabel)
    }
    
    private func setupViewAttributes() {
        backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            movieCardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            posterImageView.topAnchor.constraint(equalTo: movieCardView.topAnchor, constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: movieCardView.leadingAnchor, constant: 8),
            posterImageView.widthAnchor.constraint(equalToConstant: 50),
            posterImageView.heightAnchor.constraint(equalToConstant: 75),
            
            favoriteButton.topAnchor.constraint(equalTo: movieCardView.topAnchor, constant: 4),
            favoriteButton.trailingAnchor.constraint(equalTo: movieCardView.trailingAnchor, constant: -4),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            
            textStack.topAnchor.constraint(equalTo: movieCardView.topAnchor, constant: 8),
            textStack.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            textStack.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -4),
            movieCardView.bottomAnchor.constraint(equalTo: textStack.bottomAnchor, constant: 8)
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
        
        delegate?.didTapFavorite(movieId: movieId, isFavorite: !isFavorite)
    }
    
    private func updateFavoriteButtonAppearance() {
        let imageName = isFavorite ? "star.fill" : "star"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = isFavorite ? UIColor(named: "primaryAppColor") ?? .systemBlue : .systemGray
    }
    
    func configureCell(displayModel: MovieDisplayModel) {
        movieId = displayModel.id
        isFavorite = displayModel.isFavorite
        titleLabel.setHyphenatedText(displayModel.title)
        ratingLabel.setHyphenatedText(displayModel.ratingText)
        overviewLabel.setHyphenatedText(displayModel.overview)
        posterImageView.loadTMDBImage(path: displayModel.posterImagePath)
        updateFavoriteButtonAppearance()
    }
    
    func getCellHeight(forWidth width: CGFloat) -> CGFloat {
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

#if DEBUG
import UIKit

extension MovieViewCollectionViewCell {
    var test_debug_movieId: Int? { movieId }
    var test_debug_titleLabel: UILabel { titleLabel }
    var test_debug_ratingLabel: UILabel { ratingLabel }
    var test_debug_overviewLabel: UILabel { overviewLabel }
}
#endif
