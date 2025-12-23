import Foundation

protocol SearchMoviesInteractorLogic {
    func saveLastMovieSearch(query: String)
}

final class SearchMoviesInteractor: SearchMoviesInteractorLogic{
    private let repository: SearchMoviesRepositoryLogic
    
    init(repository: SearchMoviesRepositoryLogic) {
        self.repository = repository
    }
    
    func saveLastMovieSearch(query: String) {
        repository.saveLastMovieSearch(query: query)
    }
}
