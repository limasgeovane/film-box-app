import UIKit

protocol MovieDetailsViewLogic: UIView {
    func setupContent(displayModel: MovieDetailsDisplayModel)
    func changeState(state: MovieDetailsView.State)
}

class MovieDetailsView: UIView {
    enum State {
        case content
        case loading
        case error
    }
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.alwaysBounceVertical = true
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .title
        label.textColor = UIColor(named: "primaryAppColor")
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
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .secondaryAppFont
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .secondaryAppFont
        return label
    }()
    
    private let budgetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .secondaryAppFont
        return label
    }()
    
    private let revenueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .secondaryAppFont
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .secondaryAppFont
        label.textColor = .systemOrange
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var movieStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            backdropPathImageView,
            originalTitleLabel,
            titleLabel,
            overviewLabel,
            releaseDateLabel,
            budgetLabel,
            revenueLabel,
            ratingLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        return stackView
    }()
    
    private let loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let errorView: ErrorView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(movieDetailsCardView)
        movieDetailsCardView.addSubview(movieStackView)
        addSubview(loadingView)
        addSubview(errorView)
    }
    
    private func setupViewAttributes() {
        backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            movieDetailsCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            movieDetailsCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            movieDetailsCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            movieDetailsCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            movieStackView.topAnchor.constraint(equalTo: movieDetailsCardView.topAnchor, constant: 16),
            movieStackView.leadingAnchor.constraint(equalTo: movieDetailsCardView.leadingAnchor, constant: 16),
            movieStackView.trailingAnchor.constraint(equalTo: movieDetailsCardView.trailingAnchor, constant: -16),
            movieStackView.bottomAnchor.constraint(equalTo: movieDetailsCardView.bottomAnchor, constant: -16),
            
            errorView.topAnchor.constraint(equalTo: topAnchor),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backdropPathImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension MovieDetailsView: MovieDetailsViewLogic {
    func setupContent(displayModel: MovieDetailsDisplayModel) {
        if displayModel.backdropPath.isEmpty {
            backdropPathImageView.image = UIImage(named: "no-poster-found")
            backdropPathImageView.contentMode = .scaleAspectFit
            backdropPathImageView.backgroundColor = .clear
        } else {
            backdropPathImageView.loadTMDBImage(path: displayModel.backdropPath)
            backdropPathImageView.contentMode = .scaleAspectFill
            backdropPathImageView.backgroundColor = .systemGray5
        }
        originalTitleLabel.text = displayModel.originalTitle
        titleLabel.text = displayModel.title
        overviewLabel.text = displayModel.overview
        releaseDateLabel.text = displayModel.releaseDate
        budgetLabel.text = displayModel.budget
        revenueLabel.text = displayModel.revenue
        ratingLabel.text = displayModel.ratingText
    }
    
    func changeState(state: State) {
        switch state {
        case .content:
            movieDetailsCardView.isHidden = false
            movieStackView.isHidden = false
            loadingView.isHidden = true
            errorView.isHidden = true
        case .loading:
            movieDetailsCardView.isHidden = true
            loadingView.isHidden = false
            errorView.isHidden = true
        case .error:
            movieDetailsCardView.isHidden = false
            movieStackView.isHidden = true
            loadingView.isHidden = true
            errorView.isHidden = false
            errorView.setupMessage(message: String(localized: "requestMovieDetailsError"))
        }
    }
}
