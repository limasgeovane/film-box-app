import Foundation

protocol MovieDetailsInteractorLogic {
    func requestMovieDetails(movieId: Int)
    func favoriteMovie(movie: MovieDetailsDisplayModel)
    func unfavoriteMovie(movieId: Int)
    func isMovieFavorite(movieId: Int) -> Bool
}

final class MovieDetailsInteractor {
    weak var presenter: MovieDetailsPresenterOutputLogic?
    
    private let repository: MovieDetailsRepositoryLogic
    private let favoriteMoviesRepository: FavoriteMoviesRepositoryLogic
    
    init(
        repository: MovieDetailsRepositoryLogic,
        favoriteMoviesRepository: FavoriteMoviesRepositoryLogic
    ) {
        self.repository = repository
        self.favoriteMoviesRepository = favoriteMoviesRepository
    }
    
    private func fetchMovieDetails(movieId: Int) {
        repository.fetchMovieDetails(movieId: movieId) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let movieDetails):
                    self.presenter?.didRequestMovieDetails(movieDetails: movieDetails)
                case .failure:
                    self.presenter?.didRequestMovieDetailsError()
                }
            }
        }
    }
}

extension MovieDetailsInteractor: MovieDetailsInteractorLogic {
    func requestMovieDetails(movieId: Int) {
        fetchMovieDetails(movieId: movieId)
    }
    
    func favoriteMovie(movie: MovieDetailsDisplayModel) {
        favoriteMoviesRepository.favorite(movieId: movie.id)
    }
    
    func unfavoriteMovie(movieId: Int) {
        favoriteMoviesRepository.unfavorite(movieId: movieId)
    }
    
    func isMovieFavorite(movieId: Int) -> Bool {
        return favoriteMoviesRepository.isMovieFavorite(id: movieId)
    }
}
