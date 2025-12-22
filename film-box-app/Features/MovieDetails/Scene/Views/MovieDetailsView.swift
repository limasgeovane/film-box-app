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
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .secondary
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .secondary
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
        addSubview(movieDetailsCardView)
        movieDetailsCardView.addSubview(movieStackView)
        movieDetailsCardView.addSubview(errorView)
    }
    
    private func setupViewAttributes() {
        backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            movieDetailsCardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieDetailsCardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            movieDetailsCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            movieStackView.topAnchor.constraint(equalTo: movieDetailsCardView.topAnchor, constant: 16),
            movieStackView.leadingAnchor.constraint(equalTo: movieDetailsCardView.leadingAnchor, constant: 16),
            movieStackView.trailingAnchor.constraint(equalTo: movieDetailsCardView.trailingAnchor, constant: -16),
            movieStackView.bottomAnchor.constraint(equalTo: movieDetailsCardView.bottomAnchor, constant: -16),
            
            errorView.centerXAnchor.constraint(equalTo: movieDetailsCardView.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: movieDetailsCardView.centerYAnchor),
            errorView.leadingAnchor.constraint(equalTo: movieDetailsCardView.leadingAnchor, constant: 16),
            errorView.trailingAnchor.constraint(equalTo: movieDetailsCardView.trailingAnchor, constant: -16),
            errorView.heightAnchor.constraint(equalToConstant: 64),
            
            backdropPathImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func loadBackdropImage(path: String?) {
        guard
            let path,
            let url = URL(string: "https://image.tmdb.org/t/p/w780\(path)")
        else {
            backdropPathImageView.image = UIImage(named: "no-image")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self, let data else { return }
            DispatchQueue.main.async {
                self.backdropPathImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}

extension MovieDetailsView: MovieDetailsViewLogic {
    func setupContent(displayModel: MovieDetailsDisplayModel) {
        loadBackdropImage(path: displayModel.backdropPath)
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
