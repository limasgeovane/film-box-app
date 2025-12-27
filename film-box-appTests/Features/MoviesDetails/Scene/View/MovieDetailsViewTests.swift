import XCTest
@testable import film_box_app

final class MovieDetailsViewTests: XCTestCase {
    func test_setupContent_shouldPopulateUI() {
        let sut = MovieDetailsView()
        let movieDetailsDisplayModel = MovieDetailsDisplayModel.fixture()
        
        sut.setupContent(displayModel: movieDetailsDisplayModel)
        
        XCTAssertTrue(true)
    }
    
    var sut: MovieDetailsView!
    
    override func setUp() {
        super.setUp()
        sut = MovieDetailsView()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_changeState_shouldToggleVisibilityForContent() {
        sut.changeState(state: .content)
        XCTAssertFalse(sut.test_debug_MovieDetailsView_movieDetailsCardView.isHidden)
        XCTAssertTrue(sut.test_debug_MovieDetailsView_loadingView.isHidden)
        XCTAssertTrue(sut.test_debug_MovieDetailsView_errorView.isHidden)
    }
    
    func test_changeState_shouldToggleVisibilityForLoading() {
        sut.changeState(state: .loading)
        XCTAssertTrue(sut.test_debug_MovieDetailsView_movieDetailsCardView.isHidden)
        XCTAssertFalse(sut.test_debug_MovieDetailsView_loadingView.isHidden)
        XCTAssertTrue(sut.test_debug_MovieDetailsView_errorView.isHidden)
    }
    
    func test_changeState_shouldToggleVisibilityForError() {
        sut.changeState(state: .error)
        XCTAssertTrue(sut.test_debug_MovieDetailsView_movieDetailsCardView.isHidden)
        XCTAssertTrue(sut.test_debug_MovieDetailsView_loadingView.isHidden)
        XCTAssertFalse(sut.test_debug_MovieDetailsView_errorView.isHidden)
        XCTAssertEqual(
            sut.test_debug_MovieDetailsView_errorView.test_debug_ErrorView_errorLabel,
            String(localized: "requestMovieDetailsError")
        )
    }
}
