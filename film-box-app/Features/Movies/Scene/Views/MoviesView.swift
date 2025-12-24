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
            emptyStateView.isHidden = !movies.isEmpty
        }
    }
    
    private lazy var moviesCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
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
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(8)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 8
   
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        return UICollectionViewCompositionalLayout(section: section)
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
