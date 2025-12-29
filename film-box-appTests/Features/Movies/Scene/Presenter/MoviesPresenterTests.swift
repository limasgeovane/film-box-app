import XCTest
@testable import film_box_app

final class MoviesPresenterTests: XCTestCase {
    private let viewControllerSpy = MoviesViewControllerSpy()
    private let interactorSpy = MoviesInteractorSpy()
    private let routerSpy = MoviesRouterSpy()
    
    private var sut: MoviesPresenter!
    
    override func setUp() {
        super.setUp()
        sut = MoviesPresenter(interactor: interactorSpy, router: routerSpy)
        sut.viewController = viewControllerSpy
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_searchMovies_shouldDisplayLoadingAndCallInteractor() {
        sut.searchMovies()
        
        XCTAssertEqual(viewControllerSpy.displayLoadingCount, 1)
        XCTAssertEqual(interactorSpy.requestMoviesCount, 1)
    }
    
    func test_didTapSearch_shouldOpenSearchMovies() {
        sut.didTapSearch()
        
        XCTAssertEqual(routerSpy.openSearchMoviesCount, 1)
    }
    
    func test_didSelectMovie_shouldOpenMovieDetails() {
        sut.didSelectMovie(movieId: 99)
        
        XCTAssertEqual(routerSpy.openMovieDetailsCount, 1)
        XCTAssertEqual(routerSpy.openMovieDetailsParameterId, 99)
    }
    
    func test_didTapFavorite_shouldCallInteractorFavoriteOrUnfavorite() {
        sut.didSearchMovies(movies: [MovieEntity.fixture(id: 99)], favoriteMovies: [])
        
        sut.didTapFavorite(movieId: 99, isFavorite: true)
        XCTAssertEqual(interactorSpy.requestFavoriteMovieCount, 1)
        XCTAssertEqual(interactorSpy.requestFavoriteMovieParameter, 99)
        
        sut.didTapFavorite(movieId: 99, isFavorite: false)
        XCTAssertEqual(interactorSpy.requestUnfavoriteMovieCount, 1)
        XCTAssertEqual(interactorSpy.requestUnfavoriteMovieParameterId, 99)
    }
    
    func test_didSearchMovies_shouldTransformEntityIntoDisplayModel() {
        let movieEntity = MovieEntity.fixture()
        let expectedDisplayModel = MovieDisplayModel.fixture(isFavorite: true)
        
        sut.didSearchMovies(movies: [movieEntity], favoriteMovies: [99])
        
        XCTAssertEqual(viewControllerSpy.displayContentCount, 1)
        XCTAssertEqual(viewControllerSpy.displayContentParameterMovies, [expectedDisplayModel])
    }
    
    func test_didSearchMovies_shouldMapPosterPathCorrectly() {
        let movieEntity = MovieEntity.fixture(posterPath: "/poster.png")
        
        sut.didSearchMovies(movies: [movieEntity], favoriteMovies: [])
        
        let displayMovie = viewControllerSpy.displayContentParameterMovies.first
        XCTAssertEqual(displayMovie?.posterImagePath, "\(Constants.TmdbAPI.tmdbImageURL)/poster.png")
    }
    
    func test_didSearchMovies_withEmptyPosterPath_shouldReturnEmptyString() {
        let movieEntity = MovieEntity.fixture(posterPath: "")
        
        sut.didSearchMovies(movies: [movieEntity], favoriteMovies: [])
        
        let displayMovie = viewControllerSpy.displayContentParameterMovies.first
        XCTAssertEqual(displayMovie?.posterImagePath, "")
    }
    
    func test_didSearchMovies_withValidRating_shouldFormatRatingText() {
        let movieEntity = MovieEntity.fixture(voteAverage: 7.5)
        
        sut.didSearchMovies(movies: [movieEntity], favoriteMovies: [])
        
        let displayMovie = viewControllerSpy.displayContentParameterMovies.first
        XCTAssertEqual(displayMovie?.ratingText, "\(String(localized: "movieRating")): 7.5")
    }
    
    func test_didSearchMovies_withZeroRating_shouldReturnUnrated() {
        let movieEntity = MovieEntity.fixture(voteAverage: 0)
        
        sut.didSearchMovies(movies: [movieEntity], favoriteMovies: [])
        
        let displayMovie = viewControllerSpy.displayContentParameterMovies.first
        XCTAssertEqual(displayMovie?.ratingText, String(localized: "unrated"))
    }
    
    func test_didSearchMovies_withEmptyOverview_shouldReturnNoOverviewAvailable() {
        let movieEntity = MovieEntity.fixture(overview: "")
        
        sut.didSearchMovies(movies: [movieEntity], favoriteMovies: [])
        
        let displayMovie = viewControllerSpy.displayContentParameterMovies.first
        XCTAssertEqual(displayMovie?.overview, String(localized: "noOverviewAvailable"))
    }
    
    func test_didSearchMoviesEmpty_shouldDisplayEmptyView() {
        sut.didSearchMoviesEmpty()
        
        XCTAssertEqual(viewControllerSpy.displayEmptyViewCount, 1)
    }
    
    func test_didSearchMoviesError_shouldDisplayError() {
        sut.didSearchMoviesError()
        
        XCTAssertEqual(viewControllerSpy.displayErrorCount, 1)
    }
}
