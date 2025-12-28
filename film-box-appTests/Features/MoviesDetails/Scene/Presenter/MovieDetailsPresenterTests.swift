import XCTest
@testable import film_box_app

final class MovieDetailsPresenterTests: XCTestCase {
    let viewControllerSpy = MovieDetailsViewControllerSpy()
    let interactorSpy = MovieDetailsInteractorSpy()
    
    var sut: MovieDetailsPresenter!
    
    override func setUp() {
        super.setUp()
        sut = MovieDetailsPresenter(interactor: interactorSpy)
        sut.viewController = viewControllerSpy
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_requestMovieDetails_shouldDisplayLoadingAndCallInteractor() {
        sut.requestMovieDetails(movieId: 99)
        
        XCTAssertEqual(viewControllerSpy.displayLoadingCount, 1)
        XCTAssertEqual(interactorSpy.requestMovieDetailsCount, 1)
        XCTAssertEqual(interactorSpy.requestMovieDetailsParameterId, 99)
    }
    
    func test_didSearchMovies_shouldTransformEntityIntoDisplayModel() {
        let movieDetailsEntity = MovieDetailsEntity.fixture()
        let expectedDisplayModel = MovieDetailsDisplayModel.fixture(isFavorite: false)
        
        sut.didRequestMovieDetails(movieDetails: movieDetailsEntity)
        
        XCTAssertEqual(viewControllerSpy.displayContentCount, 1)
        XCTAssertEqual(viewControllerSpy.displayContentParameter, expectedDisplayModel)
    }
    
    func test_didRequestMovieDetailsError_shouldDisplayError() {
        sut.didRequestMovieDetailsError()
        
        XCTAssertEqual(viewControllerSpy.displayErrorCount, 1)
    }
    
    func test_didRequestMovieDetails_shouldMapBackdropPathCorrectly() {
        let movieEntity = MovieDetailsEntity.fixture(backdropPath: "/backdrop.png")
        
        sut.didRequestMovieDetails(movieDetails: movieEntity)
        
        let displayModel = viewControllerSpy.displayContentParameter
        XCTAssertEqual(displayModel?.backdropPath, "\(Constants.TmdbAPI.tmdbImageURL)/backdrop.png")
    }
    
    func test_didRequestMovieDetails_withEmptyBackdropPath_shouldReturnEmptyString() {
        let movieEntity = MovieDetailsEntity.fixture(backdropPath: "")
        
        sut.didRequestMovieDetails(movieDetails: movieEntity)
        
        let displayModel = viewControllerSpy.displayContentParameter
        XCTAssertEqual(displayModel?.backdropPath, "")
    }
    
    func test_didRequestMovieDetails_withEmptyOverview_shouldReturnNoOverviewAvailable() {
        let movieEntity = MovieDetailsEntity.fixture(overview: "")
        
        sut.didRequestMovieDetails(movieDetails: movieEntity)
        
        let displayModel = viewControllerSpy.displayContentParameter
        XCTAssertEqual(displayModel?.overview, String(localized: "noOverviewAvailable"))
    }
    
    func test_didRequestMovieDetails_withValidRating_shouldFormatRatingText() {
        let movieEntity = MovieDetailsEntity.fixture(voteAverage: 7.5)
        
        sut.didRequestMovieDetails(movieDetails: movieEntity)
        
        let displayModel = viewControllerSpy.displayContentParameter
        XCTAssertEqual(displayModel?.ratingText, "\(String(localized: "movieRating")): 7.5")
    }
    
    func test_didRequestMovieDetails_withZeroRating_shouldReturnUnrated() {
        let movieEntity = MovieDetailsEntity.fixture(voteAverage: 0)
        
        sut.didRequestMovieDetails(movieDetails: movieEntity)
        
        let displayModel = viewControllerSpy.displayContentParameter
        XCTAssertEqual(displayModel?.ratingText, String(localized: "unrated"))
    }
    
    func test_didRequestMovieDetails_withBudgetAndRevenue_shouldFormatCorrectly() {
        let movieEntity = MovieDetailsEntity.fixture(budget: 1000, revenue: 5000)
        
        sut.didRequestMovieDetails(movieDetails: movieEntity)
        
        let displayModel = viewControllerSpy.displayContentParameter
        XCTAssertTrue(displayModel?.budget.contains(String(localized: "budget")) ?? false)
        XCTAssertTrue(displayModel?.revenue.contains(String(localized: "revenue")) ?? false)
    }
    
    func test_didTapFavorite_shouldCallInteractorFavoriteOrUnfavorite() {
        let movieEntity = MovieDetailsEntity.fixture(id: 99)
        sut.didRequestMovieDetails(movieDetails: movieEntity)
        
        sut.didTapFavorite(movieId: 99, isFavorite: true)
        XCTAssertEqual(interactorSpy.favoriteMovieCount, 1)
        XCTAssertEqual(interactorSpy.favoriteMovieParameter, 99)
        
        sut.didTapFavorite(movieId: 99, isFavorite: false)
        XCTAssertEqual(interactorSpy.unfavoriteMovieCount, 1)
        XCTAssertEqual(interactorSpy.unfavoriteMovieParameterId, 99)
    }
}
