import XCTest
@testable import film_box_app

final class MoviesPresenterTests: XCTestCase {
    let viewControllerSpy = MoviesViewControllerSpy()
    let interactorSpy = MoviesInteractorSpy()
    let routerSpy = MoviesRouterSpy()
    
    lazy var sut: MoviesPresenter = {
        let presenter = MoviesPresenter(interactor: interactorSpy, router: routerSpy)
        presenter.viewController = viewControllerSpy
        return presenter
    }()
    
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
        
        sut.didTapFavorite(movieId: 99, isFavorite: false)
        XCTAssertEqual(interactorSpy.requestUnfavoriteMovieCount, 1)
    }
    
    func test_didSearchMovies_shouldMapEntitiesAndDisplayContent() {
        let entity = MovieEntity.fixture()
        sut.didSearchMovies(movies: [entity], favoriteMovies: [99])
        
        XCTAssertEqual(viewControllerSpy.displayContentCount, 1)
        XCTAssertEqual(viewControllerSpy.displayContentParameterMovies.first?.title, "Movie Title")
        XCTAssertTrue(viewControllerSpy.displayContentParameterMovies.first?.isFavorite ?? false)
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
