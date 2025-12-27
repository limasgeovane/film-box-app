import XCTest
@testable import film_box_app

final class MovieDetailsPresenterTests: XCTestCase {
    let viewControllerSpy = MovieDetailsViewControllerSpy()
    let interactorSpy = MovieDetailsInteractorSpy()
    lazy var sut: MovieDetailsPresenter = {
        let presenter = MovieDetailsPresenter(interactor: interactorSpy)
        presenter.viewController = viewControllerSpy
        return presenter
    }()
    
    func test_requestMovieDetails_shouldDisplayLoadingAndCallInteractor() {
        sut.requestMovieDetails(movieId: 99)
        
        XCTAssertEqual(viewControllerSpy.displayLoadingCount, 1)
        XCTAssertEqual(interactorSpy.requestMovieDetailsCount, 1)
        XCTAssertEqual(interactorSpy.requestMovieDetailsParameterId, 99)
    }
    
    func test_didRequestMovieDetails_shouldMapEntityAndDisplayContent() {
        let movieEntity = MovieDetailsEntity.fixture()
        
        sut.didRequestMovieDetails(movieDetails: movieEntity)
        
        XCTAssertEqual(viewControllerSpy.displayContentCount, 1)
        XCTAssertEqual(viewControllerSpy.displayContentParameter?.title, "Movie Title")
        XCTAssertEqual(viewControllerSpy.displayContentParameter?.isFavorite, interactorSpy.isMovieFavorite(movieId: movieEntity.id))
    }
    
    func test_didRequestMovieDetailsError_shouldDisplayError() {
        sut.didRequestMovieDetailsError()
        
        XCTAssertEqual(viewControllerSpy.displayErrorCount, 1)
    }
}
