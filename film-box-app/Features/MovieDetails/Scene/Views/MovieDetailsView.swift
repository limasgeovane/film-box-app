import UIKit

protocol MovieDetailsViewLogic: UIView {
    func configureView(displayModel: MovieDetailsDisplayModel)
}

class MovieDetailsView: UIView, MovieDetailsViewLogic {
    private let movieDetailsCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let backdropPathImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    private let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .title
        label.textColor = .primary
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .primary
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .secondary
        label.textAlignment = .center
        return label
    }()
    
    private let budgetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .secondary
        return label
    }()
    
    private let revenueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .secondary
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .secondary
        label.textColor = .systemOrange
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var budgetStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [budgetLabel, revenueLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            backdropPathImageView,
            originalTitleLabel,
            titleLabel,
            releaseDateLabel,
            budgetStackView,
            ratingLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
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
        addSubview(movieDetailsCardView)
        movieDetailsCardView.addSubview(mainStackView)
    }
    
    private func setupViewAttributes() {
        backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            movieDetailsCardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieDetailsCardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            movieDetailsCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            mainStackView.topAnchor.constraint(equalTo: movieDetailsCardView.topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: movieDetailsCardView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: movieDetailsCardView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: movieDetailsCardView.bottomAnchor, constant: -16),
            
            backdropPathImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureView(displayModel: MovieDetailsDisplayModel) {
        backdropPathImageView.image = UIImage(named: displayModel.backdropPath)
        originalTitleLabel.text = displayModel.originalTitle
        titleLabel.text = displayModel.title
        releaseDateLabel.text = displayModel.releaseDate
        budgetLabel.text = displayModel.budget
        revenueLabel.text = displayModel.revenue
        ratingLabel.text = displayModel.ratingText
    }
}
