import Foundation

protocol MovieDetailsInteractorLogic {
    func requestMovieDetails(movieId: Int)
    func favoriteMovie(movie: MovieDetailsDisplayModel)
    func unfavoriteMovie(movieId: Int)
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
                    self.presenter?.didRequestMovieDetails(
                        movieDetails: movieDetails
                    )
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
        let overview: String? = {
            let trimmedOverview = movie.overview.trimmingCharacters(in: .whitespacesAndNewlines)
            return (trimmedOverview.isEmpty || trimmedOverview == String(localized: "noOverviewAvailable")) ? nil : trimmedOverview
        }()
        
        let backdropPath: String? = movie.backdropPath.isEmpty
        ? nil
        : movie.backdropPath.replacingOccurrences(of: Constants.TmdbAPI.tmdbImageURL, with: "")
        
        let movieEntity = MovieEntity(
            id: movie.id,
            title: movie.title,
            overview: overview,
            voteAverage: Double(movie.ratingText.filter("0123456789.".contains)) ?? 0,
            posterPath: backdropPath
        )
        
        favoriteMoviesRepository.favorite(movie: movieEntity)
    }
    
    func unfavoriteMovie(movieId: Int) {
        favoriteMoviesRepository.unfavorite(movieId: movieId)
    }
}
