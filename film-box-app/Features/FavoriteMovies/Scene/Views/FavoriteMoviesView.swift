import UIKit

protocol FavoriteMoviesViewLogic: UIView {
    var favoriteMovies: [FavoriteMoviesDisplayModel] { get set }
    func changeState(state: FavoriteMoviesView.State)
}

class FavoriteMoviesView: UIView, FavoriteMoviesViewLogic, UICollectionViewDelegate {
    enum State {
        case content
        case loading
        case error
        case empty
    }
    
    var favoriteMovies: [FavoriteMoviesDisplayModel] = [] {
        didSet {
            favoriteMoviesCollectionView.reloadData()
            emptyStateView.isHidden = !favoriteMovies.isEmpty
        }
    }
    
    private lazy var favoriteMoviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        layout.minimumLineSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.register(FavoriteMoviesViewCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteMoviesViewCollectionViewCell.identifier)
        collection.backgroundColor = .systemBackground
        collection.delegate = self
        collection.dataSource = self
        return collection
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        addSubview(favoriteMoviesCollectionView)
        addSubview(loadingView)
        addSubview(emptyStateView)
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
        case .content:
            favoriteMoviesCollectionView.isHidden = false
            loadingView.isHidden = true
            emptyStateView.isHidden = true
            errorView.isHidden = true
        case .loading:
            favoriteMoviesCollectionView.isHidden = true
            loadingView.isHidden = false
            emptyStateView.isHidden = true
            errorView.isHidden = true
        case .error:
            favoriteMoviesCollectionView.isHidden = true
            loadingView.isHidden = true
            emptyStateView.isHidden = true
            errorView.isHidden = false
        case .empty:
            favoriteMoviesCollectionView.isHidden = true
            loadingView.isHidden = true
            emptyStateView.isHidden = false
            errorView.isHidden = true
        }
    }
}

extension FavoriteMoviesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoriteMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteMoviesViewCollectionViewCell.identifier, for: indexPath) as? FavoriteMoviesViewCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let favoriteMovie = favoriteMovies[indexPath.item]
        cell.configureCell(displayModel: favoriteMovie)
        
        return cell
    }
}
