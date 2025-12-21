import UIKit

class FavoriteMoviesViewCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "FavoriteMoviesViewCollectionViewCell"
    
    private let favoriteMovieCardView: UIView = {
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
        contentView.addSubview(favoriteMovieCardView)
        favoriteMovieCardView.addSubview(posterImageView)
        favoriteMovieCardView.addSubview(titleLabel)
        favoriteMovieCardView.addSubview(ratingLabel)
        favoriteMovieCardView.addSubview(overviewLabel)
    }
    private func setupViewAttributes() {
        backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            
            favoriteMovieCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            favoriteMovieCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            favoriteMovieCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            favoriteMovieCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            posterImageView.topAnchor.constraint(equalTo: favoriteMovieCardView.topAnchor, constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: favoriteMovieCardView.leadingAnchor, constant: 16),
            posterImageView.bottomAnchor.constraint(lessThanOrEqualTo: favoriteMovieCardView.bottomAnchor, constant: -8),
            posterImageView.widthAnchor.constraint(equalToConstant: 90),
            posterImageView.heightAnchor.constraint(equalToConstant: 130),
            
            titleLabel.topAnchor.constraint(equalTo: favoriteMovieCardView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: favoriteMovieCardView.trailingAnchor, constant: -16),
            
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            overviewLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 8),
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ])
        
        let bottomConstraint = overviewLabel.bottomAnchor.constraint(equalTo: favoriteMovieCardView.bottomAnchor, constant: -8)
        bottomConstraint.priority = .defaultHigh
        bottomConstraint.isActive = true
    }
    
    func configureCell(displayModel: FavoriteMoviesDisplayModel) {
        posterImageView.image = UIImage(named: displayModel.posterImageName)
        titleLabel.text = displayModel.title
        ratingLabel.text = displayModel.ratingText
        overviewLabel.text = displayModel.overview
    }
}
