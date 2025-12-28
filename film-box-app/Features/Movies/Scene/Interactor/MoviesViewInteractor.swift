import Foundation

protocol MoviesInteractorLogic {
    func requestSearchMovies()
    func favoriteMovie(movieId: Int)
    func unfavoriteMovie(movieId: Int)
}

final class MoviesInteractor: MoviesInteractorLogic {
    private let repository: MoviesRepositoryLogic
    private let favoriteMoviesRepository: FavoriteMoviesRepositoryLogic
    private let searchMoviesRepository: SearchMoviesRepositoryLogic
    
    weak var presenter: MoviesPresenterOutputLogic?
    
    init(
        repository: MoviesRepositoryLogic,
        favoriteMoviesRepository: FavoriteMoviesRepositoryLogic,
        searchMoviesRepository: SearchMoviesRepositoryLogic
    ) {
        self.repository = repository
        self.favoriteMoviesRepository = favoriteMoviesRepository
        self.searchMoviesRepository = searchMoviesRepository
    }
    
    func requestSearchMovies() {
        let query = repository.getLastMovieSearch() ?? ""
        
        guard !query.isEmpty else {
            presenter?.didSearchMoviesEmpty()
            return
        }
        
        repository.fetchMovies(query: query) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let movies = response.results
                    
                    guard !movies.isEmpty else {
                        self.searchMoviesRepository.saveLastMovieSearch(query: "")
                        self.presenter?.didSearchMoviesError()
                        return
                    }
                    
                    let favoriteMovies = Set(
                        movies
                            .filter { self.favoriteMoviesRepository.isMovieFavorite(id: $0.id) }
                            .map { $0.id }
                    )
                    
                    self.presenter?.didSearchMovies(
                        movies: movies,
                        favoriteMovies: favoriteMovies
                    )
                case .failure:
                    self.searchMoviesRepository.saveLastMovieSearch(query: "")
                    self.presenter?.didSearchMoviesError()
                }
            }
        }
    }
    
    func favoriteMovie(movieId: Int) {
        favoriteMoviesRepository.favorite(movieId: movieId)
    }
    
    func unfavoriteMovie(movieId: Int) {
        favoriteMoviesRepository.unfavorite(movieId: movieId)
    }
}
