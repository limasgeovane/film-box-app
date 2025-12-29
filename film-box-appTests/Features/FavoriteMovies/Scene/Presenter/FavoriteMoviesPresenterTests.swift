import XCTest
@testable import film_box_app

final class FavoriteMoviesPresenterTests: XCTestCase {
    private let viewControllerSpy = FavoriteMoviesViewControllerSpy()
    private let interactorSpy = FavoriteMoviesInteractorSpy()
    private let routerSpy = FavoriteMoviesRouterSpy()
    
    private var sut: FavoriteMoviesPresenter!
    
    override func setUp() {
        super.setUp()
        sut = FavoriteMoviesPresenter(interactor: interactorSpy, router: routerSpy)
        sut.viewController = viewControllerSpy
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_requestFavoriteMovies_shouldDisplayLoadingAndCallInteractor() {
        sut.requestFavoriteMovies()
        
        XCTAssertEqual(viewControllerSpy.displayLoadingCount, 1)
        XCTAssertEqual(interactorSpy.requestFavoriteMoviesCount, 1)
    }
    
    func test_didTapUnfavorite_shouldCallInteractorUnfavoriteMovie() {
        sut.didTapUnfavorite(movieId: 99)
        
        XCTAssertEqual(interactorSpy.requestUnfavoriteMovieCount, 1)
        XCTAssertEqual(interactorSpy.requestUnfavoriteMovieParameter, 99)
    }
    
    func test_didSelectFavoriteMovie_shouldOpenMovieDetails() {
        sut.didSelectFavoriteMovie(movieId: 42)
        
        XCTAssertEqual(routerSpy.openMovieDetailsCount, 1)
        XCTAssertEqual(routerSpy.openMovieDetailsParameter, 42)
    }
    
    func test_didRequestFavoriteMovies_shouldTransformEntityIntoDisplayModel() {
        let movieEntity = MovieDetailsEntity.fixture(id: 99)
        let expectedDisplayModel = FavoriteMoviesDisplayModel.fixture(id: 99)
        
        sut.didRequestFavoriteMovies(favoriteMovies: [movieEntity])
        
        XCTAssertEqual(viewControllerSpy.displayContentCount, 1)
        XCTAssertEqual(viewControllerSpy.displayContentParameter, [expectedDisplayModel])
    }
    
    func test_didRequestFavoriteMovies_withEmptyPosterPath_shouldReturnEmptyString() {
        let movieEntity = MovieDetailsEntity.fixture(posterPath: "")
        
        sut.didRequestFavoriteMovies(favoriteMovies: [movieEntity])
        
        let displayModel = viewControllerSpy.displayContentParameter.first
        XCTAssertEqual(displayModel?.posterImagePath, "")
    }
    
    func test_didRequestFavoriteMovies_withZeroRating_shouldReturnUnrated() {
        let movieEntity = MovieDetailsEntity.fixture(voteAverage: 0)
        
        sut.didRequestFavoriteMovies(favoriteMovies: [movieEntity])
        
        let displayModel = viewControllerSpy.displayContentParameter.first
        XCTAssertEqual(displayModel?.ratingText, String(localized: "unrated"))
    }
    
    func test_didRequestFavoriteMovies_withEmptyOverview_shouldReturnNoOverviewAvailable() {
        let movieEntity = MovieDetailsEntity.fixture(overview: "")
        
        sut.didRequestFavoriteMovies(favoriteMovies: [movieEntity])
        
        let displayModel = viewControllerSpy.displayContentParameter.first
        XCTAssertEqual(displayModel?.overview, String(localized: "noOverviewAvailable"))
    }
    
    func test_didRequestFavoriteMoviesEmpty_shouldDisplayEmptyState() {
        sut.didRequestFavoriteMoviesEmpty()
        
        XCTAssertEqual(viewControllerSpy.displayEmptyStateCount, 1)
    }
    
    func test_didRequestFavoriteMoviesError_shouldDisplayError() {
        sut.didRequestFavoriteMoviesError()
        
        XCTAssertEqual(viewControllerSpy.displayErrorCount, 1)
    }
}
