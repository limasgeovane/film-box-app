import XCTest
@testable import film_box_app

final class MoviesViewControllerTests: XCTestCase {
    let presenterSpy = MoviesPresenterSpy()
    let contentViewSpy = MoviesViewSpy()
    
    var sut: MoviesViewController!
    
    override func setUp() {
        super.setUp()
        sut = MoviesViewController(presenter: presenterSpy, contentView: contentViewSpy)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_loadView_shouldSetViewAndDelegate() {
        sut.loadView()
        
        XCTAssertTrue(sut.view is MoviesViewLogic)
        XCTAssertEqual(contentViewSpy.delegateSetterCount, 1)
    }
    
    func test_viewWillAppear_shouldCallSearchMovies() {
        sut.viewWillAppear(false)
        
        XCTAssertEqual(presenterSpy.searchMoviesCount, 1)
    }
    
    func test_searchButtonPressed_shouldCallDidTapSearch() {
        sut.loadView()
        sut.viewDidLoad()
        
        let searchButton = sut.navigationItem.rightBarButtonItem
        _ = searchButton?.target?.perform(searchButton?.action, with: nil)
        
        XCTAssertEqual(presenterSpy.didTapSearchCount, 1)
    }
    
    func test_didSelectMovie_shouldCallPresenter() {
        sut.didSelectMovie(movieId: 99)
        
        XCTAssertEqual(presenterSpy.didSelectMovieCount, 1)
        XCTAssertEqual(presenterSpy.didSelectMovieParameterId, 99)
    }
    
    func test_didFavorite_shouldCallPresenter() {
        sut.didFavorite(movieId: 99, isFavorite: true)
        
        XCTAssertEqual(presenterSpy.didTapFavoriteCount, 1)
        XCTAssertEqual(presenterSpy.didTapFavoriteParameterId, 99)
        XCTAssertEqual(presenterSpy.didTapFavoriteParameterIsFavorite, true)
    }
    
    func test_displayLoading_shouldChangeStateToLoading() {
        sut.displayLoading()
        
        XCTAssertEqual(contentViewSpy.changeStateCount, 1)
        XCTAssertEqual(contentViewSpy.changeStateParameterState, .loading)
    }
    
    func test_displayEmptyView_shouldChangeStateToEmpty() {
        sut.displayEmptyView()
        
        XCTAssertEqual(contentViewSpy.changeStateCount, 1)
        XCTAssertEqual(contentViewSpy.changeStateParameterState, .Empty)
    }
    
    func test_displayContent_shouldSetupMoviesAndChangeState() {
        let moviesDisplayModel = [MovieDisplayModel.fixture()]
        
        sut.displayContent(movies: moviesDisplayModel)
        
        XCTAssertEqual(contentViewSpy.moviesSetterCount, 1)
        XCTAssertEqual(contentViewSpy.changeStateParameterState, .content)
    }
    
    func test_displayError_shouldChangeStateToError() {
        sut.displayError()
        
        XCTAssertEqual(contentViewSpy.changeStateCount, 1)
        XCTAssertEqual(contentViewSpy.changeStateParameterState, .error)
    }
}
