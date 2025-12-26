@testable import film_box_app

final class MovieDetailsRepositorySpy: MovieDetailsRepositoryLogic {
    private(set) var fetchMovieDetailsCount = 0
    private(set) var fetchMovieDetailsParameterId: Int?
    var stubbedFetchMovieDetailsResult: Result<MovieDetailsEntity, Error>?
    
    func fetchMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetailsEntity, Error>) -> Void) {
        fetchMovieDetailsCount += 1
        fetchMovieDetailsParameterId = movieId
        
        if let result = stubbedFetchMovieDetailsResult {
            completion(result)
        }
    }
}
