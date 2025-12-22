import Foundation

protocol MovieDetailsInteractorLogic {
    func requestMovieDetails(movieId: Int)
}

final class MovieDetailsInteractor {
    private let repository: MovieDetailsRepositoryLogic
    private let presenter: MovieDetailsPresenterLogic
    
    init(
        repository: MovieDetailsRepositoryLogic,
        presenter: MovieDetailsPresenterLogic,
    ) {
        self.repository = repository
        self.presenter = presenter
    }
    
    private func fetchMovieDetails(movieId: Int) {
        presenter.responseLoading()
        
        repository.fetchMovieDetails(
            movieId: movieId
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let movieDetails):
                self.presenter.responseMovieDetails(
                    movieDetails: movieDetails
                )
            case .failure:
                self.presenter.responseError()
            }
        }
    }
}

extension MovieDetailsInteractor: MovieDetailsInteractorLogic {
    func requestMovieDetails(movieId: Int) {
        fetchMovieDetails(movieId: movieId)
    }
}
