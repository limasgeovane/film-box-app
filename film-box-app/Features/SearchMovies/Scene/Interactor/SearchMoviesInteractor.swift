protocol SearchMoviesInteractorLogic {
    func requestSearchMovies(query: String)
}

final class SearchMoviesInteractor {
    private let repository: SearchMoviesRepositoryLogic
    private let presenter: SearchMoviesPresenterLogic
    
    init(
        repository: SearchMoviesRepositoryLogic,
        presenter: SearchMoviesPresenterLogic,
    ) {
        self.repository = repository
        self.presenter = presenter
    }

    private func fetchMovies(query: String) {
        presenter.responseLoading()

        repository.fetchMovies(query: query) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.presenter.responseMovies(movies: response.results)
            case .failure:
                self.presenter.responseError()
            }
        }
    }

}

extension SearchMoviesInteractor: SearchMoviesInteractorLogic {
    func requestSearchMovies(query: String) {
        fetchMovies(query: query)
    }
}
