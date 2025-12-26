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
        sut.didSelectMovie(movieId: 42)
        XCTAssertEqual(routerSpy.openMovieDetailsCount, 1)
        XCTAssertEqual(routerSpy.openMovieDetailsParameterId, 42)
    }
    
    func test_didTapFavorite_shouldCallInteractorFavoriteOrUnfavorite() {
        let movie = MovieDisplayModel.fixture(id: 1, isFavorite: false)
        sut.didSearchMovies(movies: [MovieEntityFixture.makeMovie(id: 1)], favoriteMovies: [])
        
        sut.didTapFavorite(movieId: 1, isFavorite: true)
        XCTAssertEqual(interactorSpy.requestFavoriteMovieCount, 1)
        
        sut.didTapFavorite(movieId: 1, isFavorite: false)
        XCTAssertEqual(interactorSpy.requestUnfavoriteMovieCount, 1)
    }
    
    func test_didSearchMovies_shouldMapEntitiesAndDisplayContent() {
        let entity = MovieEntityFixture.makeMovie(id: 1, title: "Matrix")
        sut.didSearchMovies(movies: [entity], favoriteMovies: [1])
        
        XCTAssertEqual(viewControllerSpy.displayContentCount, 1)
        XCTAssertEqual(viewControllerSpy.displayContentParameterMovies.first?.title, "Matrix")
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
