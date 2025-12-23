import Foundation

protocol SearchMoviesInteractorLogic {
    func requestSearchMovies(query: String)
}

final class SearchMoviesInteractor {
    weak var presenter: SearchMoviesPresenterOutputLogic?
    
    private let repository: SearchMoviesRepositoryLogic
    
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
        repository.saveLastMovieSearch(query: query)
        fetchSearchMovies(query: query)
    }
}
