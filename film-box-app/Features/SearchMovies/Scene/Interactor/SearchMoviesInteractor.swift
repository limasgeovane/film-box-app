protocol SearchMoviesInteractorLogic: AnyObject {
    func requestSearchMovies(query: String)
}

final class SearchMoviesInteractor: SearchMoviesInteractorLogic {
    private let repository: SearchMoviesRepositoryLogic
    weak var presenter: SearchMoviesPresenterLogic?
    
    init(repository: SearchMoviesRepositoryLogic) {
        self.repository = repository
    }
    
    func requestSearchMovies(query: String) {
        repository.fetchMovies(query: query) { [weak self] result in
            guard let self = self else { return }
            
            let mapResult = result.map { $0.results }
            
            self.presenter?.didFetchMovies(result: mapResult)
        }
    }
}
