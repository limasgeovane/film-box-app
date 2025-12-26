@testable import film_box_app

final class MovieDetailsPresenterSpy: MovieDetailsPresenterInputLogic, MovieDetailsPresenterOutputLogic {
    private(set) var requestMovieDetailsCount = 0
    private(set) var requestMovieDetailsParameterId: Int?
    func requestMovieDetails(movieId: Int) {
        requestMovieDetailsCount += 1
        requestMovieDetailsParameterId = movieId
    }
    
    private(set) var didRequestMovieDetailsCount = 0
    private(set) var didRequestMovieDetailsParameter: MovieDetailsEntity?
    func didRequestMovieDetails(movieDetails: MovieDetailsEntity) {
        didRequestMovieDetailsCount += 1
        didRequestMovieDetailsParameter = movieDetails
    }
    
    private(set) var didRequestMovieDetailsErrorCount = 0
    func didRequestMovieDetailsError() {
        didRequestMovieDetailsErrorCount += 1
    }
}
