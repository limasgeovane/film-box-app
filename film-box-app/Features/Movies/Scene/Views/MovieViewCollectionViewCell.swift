import UIKit

protocol MovieViewCollectionViewCellDelegate: AnyObject {
    func didTapFavorite(movieId: Int, isFavorite: Bool)
}

class MovieViewCollectionViewCell: UICollectionViewCell {
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
        label.font = .title
        label.textColor = .primary
        label.numberOfLines = 0
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
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .primary
        label.textColor = .systemOrange
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .secondary
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
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
        movieCardView.addSubview(titleLabel)
        movieCardView.addSubview(favoriteButton)
        movieCardView.addSubview(ratingLabel)
        movieCardView.addSubview(overviewLabel)
    }
    
    private func setupViewAttributes() {
        backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            
            movieCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            movieCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            posterImageView.topAnchor.constraint(equalTo: movieCardView.topAnchor, constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: movieCardView.leadingAnchor, constant: 16),
            posterImageView.bottomAnchor.constraint(lessThanOrEqualTo: movieCardView.bottomAnchor, constant: -8),
            posterImageView.widthAnchor.constraint(equalToConstant: 90),
            posterImageView.heightAnchor.constraint(equalToConstant: 130),
            
            favoriteButton.topAnchor.constraint(equalTo: movieCardView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: movieCardView.trailingAnchor, constant: -16),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: movieCardView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -8),
            
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: movieCardView.trailingAnchor, constant: -16),
            
            overviewLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 8),
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: movieCardView.trailingAnchor, constant: -16),
        ])
        
        let bottomConstraint = overviewLabel.bottomAnchor.constraint(equalTo: movieCardView.bottomAnchor, constant: -8)
        bottomConstraint.priority = .defaultHigh
        bottomConstraint.isActive = true
    }
    
    func configureCell(displayModel: MovieDisplayModel) {
        movieId = displayModel.id
        isFavorite = displayModel.isFavorite
        posterImageView.loadTMDBImage(path: displayModel.posterImageName)
        titleLabel.text = displayModel.title
        ratingLabel.text = displayModel.ratingText
        overviewLabel.text = displayModel.overview
        updateFavoriteButtonAppearance()
    }
    
    @objc private func favoriteButtonPressed() {
        guard let movieId else { return }
        
        isFavorite = !isFavorite
        updateFavoriteButtonAppearance()
        
        delegate?.didTapFavorite(movieId: movieId, isFavorite: isFavorite)
    }
    
    private func updateFavoriteButtonAppearance() {
        let imageName = isFavorite ? "star.fill" : "star"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = isFavorite ? UIColor(named: "primaryColor") ?? .systemBlue : .systemGray
    }
}
