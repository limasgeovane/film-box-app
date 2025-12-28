import XCTest
@testable import film_box_app

final class MoviesViewTests: XCTestCase {
    var sut: MoviesView!
    
    override func setUp() {
        super.setUp()
        sut = MoviesView()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_changeState_shouldToggleVisibilityForLoading() {
        sut.changeState(state: .loading)
        
        XCTAssertFalse(sut.test_debug_loadingView.isHidden)
        XCTAssertTrue(sut.test_debug_moviesCollectionView.isHidden)
        XCTAssertTrue(sut.test_debug_emptyStateView.isHidden)
        XCTAssertTrue(sut.test_debug_errorView.isHidden)
    }
    
    func test_changeState_shouldToggleVisibilityForContent() {
        sut.changeState(state: .content)
        
        XCTAssertTrue(sut.test_debug_loadingView.isHidden)
        XCTAssertFalse(sut.test_debug_moviesCollectionView.isHidden)
        XCTAssertTrue(sut.test_debug_emptyStateView.isHidden)
        XCTAssertTrue(sut.test_debug_errorView.isHidden)
    }
    
    func test_changeState_shouldToggleVisibilityForEmpty() {
        sut.changeState(state: .Empty)
        
        XCTAssertTrue(sut.test_debug_loadingView.isHidden)
        XCTAssertTrue(sut.test_debug_moviesCollectionView.isHidden)
        XCTAssertFalse(sut.test_debug_emptyStateView.isHidden)
        XCTAssertTrue(sut.test_debug_errorView.isHidden)
    }
    
    func test_changeState_shouldToggleVisibilityForError() {
        sut.changeState(state: .error)
        
        XCTAssertTrue(sut.test_debug_loadingView.isHidden)
        XCTAssertTrue(sut.test_debug_moviesCollectionView.isHidden)
        XCTAssertTrue(sut.test_debug_emptyStateView.isHidden)
        XCTAssertFalse(sut.test_debug_errorView.isHidden)
        XCTAssertEqual(
            sut.test_debug_errorView.test_debug_errorLabel,
            String(localized: "requestMoviesError")
        )
    }
}
