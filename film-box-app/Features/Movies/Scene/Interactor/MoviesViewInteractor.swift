import Foundation

protocol MoviesInteractorLogic {
    func requestSearchMovies()
    func favoriteMovie(movie: MovieDisplayModel)
    func unfavoriteMovie(movieId: Int)
}

final class MoviesInteractor: MoviesInteractorLogic {
    private let repository: MoviesRepositoryLogic
    private let favoriteMoviesRepository: FavoriteMoviesRepositoryLogic
    
    weak var presenter: MoviesPresenterOutputLogic?
    
    init(
        repository: MoviesRepositoryLogic,
        favoriteMoviesRepository: FavoriteMoviesRepositoryLogic
    ) {
        self.repository = repository
        self.favoriteMoviesRepository = favoriteMoviesRepository
    }
    
    func requestSearchMovies() {
        let query = repository.getLastMovieSearch() ?? ""
        
        repository.fetchMovies(query: query) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let movies = response.results
                    
                    guard !movies.isEmpty else {
                        self.presenter?.didSearchMoviesEmpty()
                        return
                    }
                    
                    self.presenter?.didSearchMovies(movies: movies)
                case .failure:
                    self.presenter?.didSearchMoviesError()
                }
            }
        }
    }
    
    func favoriteMovie(movie: MovieDisplayModel) {
        let favoriteMovie = FavoriteMoviesDisplayModel(
            id: movie.id,
            title: movie.title,
            posterImageName: movie.posterImagePath,
            ratingText: movie.ratingText,
            overview: movie.overview
        )
        favoriteMoviesRepository.favorite(favoriteMovie: favoriteMovie)
    }
    
    func unfavoriteMovie(movieId: Int) {
        favoriteMoviesRepository.unfavorite(movieId: movieId)
    }
}
