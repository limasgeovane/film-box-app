import Foundation

protocol FavoriteMoviesInteractorLogic {
    func requestFavoriteMovies()
    func unfavoriteMovie(movieId: Int)
}

final class FavoriteMoviesInteractor {
    weak var presenter: FavoriteMoviesPresenterOutputLogic?
    
    private let repository: FavoriteMoviesRepositoryLogic
    private let movieDetailsRepository: MovieDetailsRepositoryLogic
    
    init(
        repository: FavoriteMoviesRepositoryLogic,
        movieDetailsRepository: MovieDetailsRepositoryLogic
    ) {
        self.repository = repository
        self.movieDetailsRepository = movieDetailsRepository
    }
    
    private func fetchFavoriteMovies() {
        let favoriteIds = repository.getFavoritesIds()
        
        if favoriteIds.isEmpty {
            presenter?.didRequestFavoriteMoviesEmpty()
            return
        }
        
        var movies: [MovieEntity] = []
        let group = DispatchGroup()
        var hasError = false
        
        let syncQueue = DispatchQueue(label: "favorites.sync.queue")
        
        for id in favoriteIds {
            group.enter()
            
            movieDetailsRepository.fetchMovieDetails(movieId: id) { result in
                syncQueue.async {
                    switch result {
                    case .success(let details):
                        let movie = MovieEntity(
                            id: details.id,
                            title: details.title,
                            overview: details.overview,
                            voteAverage: details.voteAverage,
                            posterPath: details.backdropPath
                        )
                        movies.append(movie)
                        
                    case .failure:
                        hasError = true
                    }
                    
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            if movies.isEmpty {
                if hasError {
                    self.presenter?.didRequestFavoriteMoviesError()
                } else {
                    self.presenter?.didRequestFavoriteMoviesEmpty()
                }
            } else {
                self.presenter?.didRequestFavoriteMovies(favoriteMovies: movies)
            }
        }
    }
}

extension FavoriteMoviesInteractor: FavoriteMoviesInteractorLogic {
    func requestFavoriteMovies() {
        fetchFavoriteMovies()
    }
    
    func unfavoriteMovie(movieId: Int) {
        repository.unfavorite(movieId: movieId)
        fetchFavoriteMovies()
    }
}
