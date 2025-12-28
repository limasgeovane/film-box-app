import UIKit

protocol MoviesViewDelegate: AnyObject {
    func didSelectMovie(movieId: Int)
    func didFavorite(movieId: Int, isFavorite: Bool)
}

protocol MoviesViewLogic: UIView {
    var delegate: MoviesViewDelegate? { get set }
    var movies: [MovieDisplayModel] { get set }
    
    func reloadMovieCell(index: Int)
    func changeState(state: MoviesView.State)
}

final class MoviesView: UIView, MoviesViewLogic {
    enum State {
        case loading
        case Empty
        case content
        case error
    }
    
    weak var delegate: MoviesViewDelegate?
    
    var movies: [MovieDisplayModel] = [] {
        didSet {
            moviesCollectionView.reloadData()
            moviesCollectionView.collectionViewLayout.invalidateLayout()
            emptyStateView.isHidden = !movies.isEmpty
        }
    }
    
    private lazy var moviesCollectionView: UICollectionView = {
        let layout = DynamicHeightGridView()
        layout.delegate = self
        layout.sizingProvider = self
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.register(MovieViewCollectionViewCell.self, forCellWithReuseIdentifier: MovieViewCollectionViewCell.identifier)
        collection.backgroundColor = .systemBackground
        collection.delegate = self
        collection.dataSource = self
        collection.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return collection
    }()
    
    private lazy var sizingCell: MovieViewCollectionViewCell = {
        let cell = MovieViewCollectionViewCell(frame: .zero)
        return cell
    }()
    
    private let emptyStateView = {
        let view = EmptyStateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setupMessage(message: String(localized: "emptyMovies"))
        return view
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
        changeState(state: .loading)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        addSubview(moviesCollectionView)
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
            
            moviesCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            moviesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            moviesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
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
    
    func reloadMovieCell(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        
        moviesCollectionView.reloadItems(at: [indexPath])
        moviesCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func changeState(state: State) {
        switch state {
        case .loading:
            loadingView.isHidden = false
            moviesCollectionView.isHidden = true
            emptyStateView.isHidden = true
            errorView.isHidden = true
        case .content:
            loadingView.isHidden = true
            moviesCollectionView.isHidden = false
            emptyStateView.isHidden = true
            errorView.isHidden = true
        case .Empty:
            loadingView.isHidden = true
            moviesCollectionView.isHidden = true
            emptyStateView.isHidden = false
            errorView.isHidden = true
        case .error:
            loadingView.isHidden = true
            moviesCollectionView.isHidden = true
            emptyStateView.isHidden = true
            errorView.isHidden = false
            errorView.setupMessage(message: String(localized: "requestMoviesError"))
        }
    }
}

extension MoviesView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieViewCollectionViewCell.identifier,
            for: indexPath
        ) as? MovieViewCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(displayModel: movies[indexPath.item])
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectMovie(movieId: movies[indexPath.item].id)
    }
}

extension MoviesView: DynamicHeightGridViewDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension MoviesView: DynamicHeightSizingProvider {
    func heightForItem(at indexPath: IndexPath, in width: CGFloat) -> CGFloat {
        guard movies.indices.contains(indexPath.item) else {
            return 180
        }
        
        let displayModel = movies[indexPath.item]
        
        sizingCell.prepareForReuse()
        sizingCell.configureCell(displayModel: displayModel)
        
        let height = sizingCell.getCellHeight(forWidth: width)
        
        return max(91, height)
    }
}

extension MoviesView: MovieViewCollectionViewCellDelegate {
    func didTapFavorite(movieId: Int, isFavorite: Bool) {
        if let index = movies.firstIndex(where: { $0.id == movieId }) {
            movies[index].isFavorite = isFavorite
            reloadMovieCell(index: index)
        }

        delegate?.didFavorite(movieId: movieId, isFavorite: isFavorite)
    }
}

#if DEBUG
extension MoviesView {
    var test_debug_loadingView: LoadingView { loadingView }
    var test_debug_moviesCollectionView: UIView { moviesCollectionView }
    var test_debug_emptyStateView: EmptyStateView { emptyStateView }
    var test_debug_errorView: ErrorView { errorView }
}
#endif
