@testable import film_box_app
import Foundation

final class MovieDetailsInteractorSpy: MovieDetailsInteractorLogic {
    private(set) var requestMovieDetailsCount = 0
    private(set) var requestMovieDetailsParameterId: Int?

    func requestMovieDetails(movieId: Int) {
        requestMovieDetailsCount += 1
        requestMovieDetailsParameterId = movieId
    }
}
