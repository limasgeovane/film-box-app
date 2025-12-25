import UIKit

protocol FavoriteMoviesViewDelegate: AnyObject {
    func didSelectFavoriteMovie(movieId: Int)
    func didTapUnfavorite(movieId: Int)
}

protocol FavoriteMoviesViewLogic: UIView {
    var favoriteMovies: [FavoriteMoviesDisplayModel] { get set }
    var delegate: FavoriteMoviesViewDelegate? { get set }
    func changeState(state: FavoriteMoviesView.State)
}

class FavoriteMoviesView: UIView, FavoriteMoviesViewLogic {
    weak var delegate: FavoriteMoviesViewDelegate?
    
    enum State {
        case content
        case loading
        case empty
    }
    
    var favoriteMovies: [FavoriteMoviesDisplayModel] = [] {
        didSet {
            favoriteMoviesCollectionView.reloadData()
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
        collection.register(FavoriteMoviesViewCollectionViewCell.self,
                            forCellWithReuseIdentifier: FavoriteMoviesViewCollectionViewCell.identifier)
        collection.backgroundColor = .systemBackground
        collection.delegate = self
        collection.dataSource = self
        collection.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return collection
    }()
    
    private lazy var sizingCell: FavoriteMoviesViewCollectionViewCell = {
        let cell = FavoriteMoviesViewCollectionViewCell(frame: .zero)
        return cell
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
        addSubview(favoriteMoviesCollectionView)
        addSubview(loadingView)
        addSubview(emptyStateView)
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
            emptyStateView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func changeState(state: State) {
        switch state {
        case .content:
            favoriteMoviesCollectionView.isHidden = false
            loadingView.isHidden = true
            emptyStateView.isHidden = true
        case .loading:
            favoriteMoviesCollectionView.isHidden = true
            loadingView.isHidden = false
            emptyStateView.isHidden = true
        case .empty:
            favoriteMoviesCollectionView.isHidden = true
            loadingView.isHidden = true
            emptyStateView.isHidden = false
        }
    }
}

extension FavoriteMoviesView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoriteMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 180
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
        
        let height = sizingCell.fittingHeight(forWidth: width)
        
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
