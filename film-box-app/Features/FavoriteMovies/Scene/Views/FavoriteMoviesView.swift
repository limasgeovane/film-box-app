import UIKit

protocol FavoriteMoviesViewLogic: UIView, AnyObject {
    var favoriteMovies: [FavoriteMoviesDisplayModel] { get set }
}

class FavoriteMoviesView: UIView, FavoriteMoviesViewLogic, UICollectionViewDelegate {
    var favoriteMovies: [FavoriteMoviesDisplayModel] = [] {
        didSet {
            favoriteMoviesCollectionView.reloadData()
        }
    }
    
    private lazy var favoriteMoviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 200)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.register(FavoriteMoviesViewCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteMoviesViewCollectionViewCell.identifier)
        collection.backgroundColor = .systemBackground
        collection.delegate = self
        collection.dataSource = self
        return collection
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
    }
    
    private func setupViewAttributes() {
        backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            favoriteMoviesCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            favoriteMoviesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favoriteMoviesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favoriteMoviesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
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
