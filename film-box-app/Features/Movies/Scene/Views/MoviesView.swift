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
    
    var movies: [MovieDisplayModel] = [] {
        didSet {
            moviesCollectionView.reloadData()
            emptyStateView.isHidden = !movies.isEmpty // verificar
        }
    }
    
    private lazy var moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        layout.minimumLineSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.register(MovieViewCollectionViewCell.self, forCellWithReuseIdentifier: MovieViewCollectionViewCell.identifier)
        collection.backgroundColor = .systemBackground
        collection.delegate = self
        collection.dataSource = self
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
    
    weak var delegate: MoviesViewDelegate?
    
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
    }
    
    func changeState(state: State) {
        switch state {
        case .loading:
            loadingView.isHidden = false
            moviesCollectionView.isHidden = false
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

extension MoviesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieViewCollectionViewCell.identifier, for: indexPath) as? MovieViewCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movie = movies[indexPath.item]
        cell.configureCell(displayModel: movie)
        
        cell.delegate = delegate as? MovieViewCollectionViewCellDelegate
        
        return cell
    }
}

extension MoviesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.item]
        delegate?.didSelectMovie(movieId: movie.id)
    }
}
