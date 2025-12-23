import Foundation

protocol SearchMoviesInteractorLogic {
    func requestSearchMovies(query: String)
}

final class SearchMoviesInteractor {
    private let repository: SearchMoviesRepositoryLogic
    weak var presenter: SearchMoviesPresenterOutputLogic?
    
    init(repository: SearchMoviesRepositoryLogic) {
        self.repository = repository
    }
    
    private func fetchSearchMovies(query: String) {
        repository.fetchMovies(query: query) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let movies = response.results
                    
                    guard !movies.isEmpty else {
                        self.presenter?.didSearchMoviesError()
                        return
                    }
                    
                    self.presenter?.didSearchMovies(movies: movies)
                case .failure:
                    self.presenter?.didSearchMoviesError()
                }
            }
        }
    }
}

extension SearchMoviesInteractor: SearchMoviesInteractorLogic {
    func requestSearchMovies(query: String) {
        fetchSearchMovies(query: query)
    }
}
