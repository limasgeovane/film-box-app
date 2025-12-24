import UIKit

protocol MoviesViewDelegate: AnyObject {
    func didSelectMovie(movieId: Int)
}

protocol MoviesViewLogic: UIView {
    var delegate: MoviesViewDelegate? { get set }
    var movies: [MovieDisplayModel] { get set }
    
    func reloadMovieCell(index: Int)
    func changeState(state: MoviesView.State)
}

class MoviesView: UIView, MoviesViewLogic {
    enum State {
        case loading
        case Empty
        case content
        case error
    }
    
    weak var delegate: MoviesViewDelegate?
    
    var movies: [MovieDisplayModel] = [] {
        didSet {
            if let layout = moviesCollectionView.collectionViewLayout as? DynamicHeightGridView {
                layout.invalidateLayout()
            }
            moviesCollectionView.reloadData()
            emptyStateView.isHidden = !movies.isEmpty
        }
    }
    
    private lazy var moviesCollectionView: UICollectionView = {
        let layout = DynamicHeightGridView()
        layout.delegate = self
        
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
    
    private let emptyStateView: EmptyStateView = {
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
            
            emptyStateView.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyStateView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            errorView.topAnchor.constraint(equalTo: topAnchor),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func reloadMovieCell(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        moviesCollectionView.reloadItems(at: [indexPath])
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
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieViewCollectionViewCell.identifier, for: indexPath) as? MovieViewCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(displayModel: movies[indexPath.item])
        cell.delegate = delegate as? MovieViewCollectionViewCellDelegate
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectMovie(movieId: movies[indexPath.item].id)
    }
}

extension MoviesView: DynamicHeightGridViewDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let movie = movies[indexPath.item]
        let columnWidth = (collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right) / 2
        let textWidth = columnWidth - 16 - 50 - 8 - 34
        let titleFont = UIFont.systemFont(ofSize: 14, weight: .bold)
        let overviewFont = UIFont.systemFont(ofSize: 12)
        let titleHeight = movie.title.height(withConstrainedWidth: textWidth, font: titleFont)
        let overviewHeight = movie.overview.height(withConstrainedWidth: textWidth, font: overviewFont)
        let totalTextContent = 8 + titleHeight + 8 + 15 + 8 + overviewHeight + 8
        let finalHeight = max(91, totalTextContent)
        
        return finalHeight
    }
}
