import XCTest
@testable import film_box_app

final class MovieDetailsPresenterTests: XCTestCase {
    let viewControllerSpy = MovieDetailsViewControllerSpy()
    let interactorSpy = MovieDetailsInteractorSpy() // opcional, se quiser contar chamada
    lazy var sut: MovieDetailsPresenter = {
        let presenter = MovieDetailsPresenter(interactor: interactorSpy)
        presenter.viewController = viewControllerSpy
        return presenter
    }()
    
    func test_requestMovieDetails_shouldDisplayLoadingAndCallInteractor() {
        sut.requestMovieDetails(movieId: 7)
        
        XCTAssertEqual(viewControllerSpy.displayLoadingCount, 1)
        XCTAssertEqual(interactorSpy.requestMovieDetailsCount, 1)
        XCTAssertEqual(interactorSpy.requestMovieDetailsParameterId, 7)
    }
    
    func test_didRequestMovieDetails_shouldMapEntityAndDisplayContent() {
        let entity = MovieDetailsEntityFixture.make(
            backdropPath: "/bd.jpg",
            overview: "Overview",
            budget: 1_000_000,
            revenue: 5_000_000,
            voteAverage: 8.5
        )
        
        sut.didRequestMovieDetails(movieDetails: entity)
        
        XCTAssertEqual(viewControllerSpy.displayContentCount, 1)
        let display = viewControllerSpy.displayContentParameter
        XCTAssertEqual(display?.backdropPath, "\(Constants.TmdbAPI.tmdbImageURL)/bd.jpg")
        XCTAssertEqual(display?.title, entity.title)
        XCTAssertEqual(display?.overview, "Overview")
        XCTAssertEqual(display?.ratingText, "\(String(localized: "movieRating")): 8.5")
    }
    
    func test_didRequestMovieDetailsError_shouldDisplayError() {
        sut.didRequestMovieDetailsError()
        
        XCTAssertEqual(viewControllerSpy.displayErrorCount, 1)
    }
}
