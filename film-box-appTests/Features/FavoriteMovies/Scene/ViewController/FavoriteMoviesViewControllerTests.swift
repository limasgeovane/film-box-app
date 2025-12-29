import XCTest
@testable import film_box_app

final class FavoriteMoviesViewControllerTests: XCTestCase {
    private let presenterSpy = FavoriteMoviesPresenterSpy()
    private let contentViewSpy = FavoriteMoviesViewSpy()
    
    private var sut: FavoriteMoviesViewController!
    
    override func setUp() {
        super.setUp()
        sut = FavoriteMoviesViewController(presenter: presenterSpy, contentView: contentViewSpy)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_loadView_shouldSetViewAndDelegate() {
        sut.loadView()
        
        XCTAssertTrue(sut.view is FavoriteMoviesViewLogic)
        XCTAssertEqual(contentViewSpy.delegateSetterCount, 1)
    }
    
    func test_viewWillAppear_shouldCallRequestFavoriteMovies() {
        sut.viewWillAppear(false)
        
        XCTAssertEqual(presenterSpy.requestFavoriteMoviesCount, 1)
    }
    
    func test_didSelectFavoriteMovie_shouldCallPresenter() {
        sut.didSelectFavoriteMovie(movieId: 99)
        
        XCTAssertEqual(presenterSpy.didSelectFavoriteMovieCount, 1)
        XCTAssertEqual(presenterSpy.didSelectFavoriteMovieParameter, 99)
    }
    
    func test_didTapUnfavorite_shouldCallPresenter() {
        sut.didTapUnfavorite(movieId: 42)
        
        XCTAssertEqual(presenterSpy.didTapUnfavoriteCount, 1)
        XCTAssertEqual(presenterSpy.didTapUnfavoriteParameter, 42)
    }
    
    func test_displayLoading_shouldChangeStateToLoading() {
        sut.displayLoading()
        
        XCTAssertEqual(contentViewSpy.changeStateCount, 1)
        XCTAssertEqual(contentViewSpy.changeStateParameterState, .loading)
    }
    
    func test_displayContent_shouldSetupFavoriteMoviesAndChangeState() {
        let favoritesDisplayModel = [FavoriteMoviesDisplayModel.fixture()]
        
        sut.displayContent(displayModel: favoritesDisplayModel)
        
        XCTAssertEqual(contentViewSpy.favoriteMoviesSetterCount, 1)
        XCTAssertEqual(contentViewSpy.invokedFavoriteMoviesMovies, favoritesDisplayModel)
        XCTAssertEqual(contentViewSpy.changeStateParameterState, .content)
    }
    
    func test_displayEmptyState_shouldClearMoviesAndChangeStateToEmpty() {
        sut.displayEmptyState()
        
        XCTAssertEqual(contentViewSpy.favoriteMoviesSetterCount, 1)
        XCTAssertEqual(contentViewSpy.invokedFavoriteMoviesMovies, [])
        XCTAssertEqual(contentViewSpy.changeStateParameterState, .empty)
    }
    
    func test_displayError_shouldClearMoviesAndChangeStateToError() {
        sut.displayError()
        
        XCTAssertEqual(contentViewSpy.favoriteMoviesSetterCount, 1)
        XCTAssertEqual(contentViewSpy.invokedFavoriteMoviesMovies, [])
        XCTAssertEqual(contentViewSpy.changeStateParameterState, .error)
    }
}
