import UIKit

protocol FavoriteMoviesViewDelegate: AnyObject {
    func didSelectFavoriteMovie(movieId: Int)
    func didTapUnfavorite(movieId: Int)
}

protocol FavoriteMoviesViewLogic: UIView {
    var delegate: FavoriteMoviesViewDelegate? { get set }
    var favoriteMovies: [FavoriteMoviesDisplayModel] { get set }
    
    func changeState(state: FavoriteMoviesView.State)
}

final class FavoriteMoviesView: UIView, FavoriteMoviesViewLogic {
    enum State {
        case loading
        case content
        case empty
        case error
    }
    
    weak var delegate: FavoriteMoviesViewDelegate?
    
    var favoriteMovies: [FavoriteMoviesDisplayModel] = [] {
        didSet {
            favoriteMoviesCollectionView.reloadData()
            favoriteMoviesCollectionView.collectionViewLayout.invalidateLayout()
            emptyStateView.isHidden = !favoriteMovies.isEmpty
        }
    }
    
    private lazy var favoriteMoviesCollectionView: UICollectionView = {
        let layout = DynamicHeightGridView()
        layout.delegate = self
        layout.sizingProvider = self
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.register(
            FavoriteMoviesViewCollectionViewCell.self,
            forCellWithReuseIdentifier: FavoriteMoviesViewCollectionViewCell.identifier
        )
        collection.backgroundColor = .systemBackground
        collection.delegate = self
        collection.dataSource = self
        collection.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return collection
    }()
    
    private lazy var sizingCell: FavoriteMoviesViewCollectionViewCell = {
        FavoriteMoviesViewCollectionViewCell(frame: .zero)
    }()
    
    private let loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emptyStateView: EmptyStateView = {
        let view = EmptyStateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setupMessage(message: String(localized: "emptyFavoritesMovies"))
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
        changeState(state: .loading)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        addSubview(favoriteMoviesCollectionView)
        addSubview(emptyStateView)
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
            
            favoriteMoviesCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            favoriteMoviesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favoriteMoviesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favoriteMoviesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            emptyStateView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            emptyStateView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emptyStateView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            emptyStateView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            errorView.topAnchor.constraint(equalTo: topAnchor),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func changeState(state: State) {
        switch state {
        case .loading:
            loadingView.isHidden = false
            favoriteMoviesCollectionView.isHidden = true
            emptyStateView.isHidden = true
            errorView.isHidden = true
        case .content:
            loadingView.isHidden = true
            favoriteMoviesCollectionView.isHidden = false
            emptyStateView.isHidden = true
            errorView.isHidden = true
        case .empty:
            loadingView.isHidden = true
            favoriteMoviesCollectionView.isHidden = true
            emptyStateView.isHidden = false
            errorView.isHidden = true
        case .error:
            loadingView.isHidden = true
            favoriteMoviesCollectionView.isHidden = true
            emptyStateView.isHidden = true
            errorView.isHidden = false
            errorView.setupMessage(message: String(localized: "requestMoviesError"))
        }
    }
}

extension FavoriteMoviesView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoriteMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FavoriteMoviesViewCollectionViewCell.identifier,
            for: indexPath
        ) as? FavoriteMoviesViewCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(displayModel: favoriteMovies[indexPath.item])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectFavoriteMovie(movieId: favoriteMovies[indexPath.item].id)
    }
}

extension FavoriteMoviesView: DynamicHeightGridViewDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        180
    }
}

extension FavoriteMoviesView: DynamicHeightSizingProvider {
    func heightForItem(at indexPath: IndexPath, in width: CGFloat) -> CGFloat {
        guard favoriteMovies.indices.contains(indexPath.item) else {
            return 180
        }
        
        let displayModel = favoriteMovies[indexPath.item]
        
        sizingCell.prepareForReuse()
        sizingCell.configureCell(displayModel: displayModel)
        
        let height = sizingCell.getCellHeight(forWidth: width)
        return max(91, height)
    }
}

extension FavoriteMoviesView: FavoriteMoviesViewCollectionViewCellDelegate {
    func didTapUnfavorite(movieId: Int) {
        if let index = favoriteMovies.firstIndex(where: { $0.id == movieId }) {
            favoriteMovies.remove(at: index)
        }
        
        delegate?.didTapUnfavorite(movieId: movieId)
    }
}
