import Foundation

protocol MovieDetailsInteractorLogic {
    func requestMovieDetails(movieId: Int)
}

final class MovieDetailsInteractor {
    private let repository: MovieDetailsRepositoryLogic
    weak var presenter: MovieDetailsPresenterOutputLogic?
    
    init(repository: MovieDetailsRepositoryLogic) {
        self.repository = repository
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
}
