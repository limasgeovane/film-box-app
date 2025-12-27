@testable import film_box_app

final class MoviesRepositorySpy: MoviesRepositoryLogic {
    private(set) var fetchMovieCount = 0
    private(set) var fetchMoviesParameterString: String?
    var stubbedFetchMovieCompletionResult: Result<MoviesResponseEntity, Error>?
    func fetchMovies(query: String, completion: @escaping (Result<MoviesResponseEntity, Error>) -> Void) {
        fetchMovieCount += 1
        fetchMoviesParameterString = query
        
        if let result = stubbedFetchMovieCompletionResult {
            completion(result)
        }
    }
    
    var stubbedGetLastMovieSearchResult: String? = "query"
    func getLastMovieSearch() -> String? {
        return stubbedGetLastMovieSearchResult
    }
}
