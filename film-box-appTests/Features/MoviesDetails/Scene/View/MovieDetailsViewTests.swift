import XCTest
@testable import film_box_app

final class MovieDetailsViewTests: XCTestCase {
    let movieDetailsDisplayModel = MovieDetailsDisplayModel.fixture()
    
    var sut: MovieDetailsView!
    
    override func setUp() {
        super.setUp()
        sut = MovieDetailsView()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_setupContent_shouldPopulateUI() {
        sut.setupContent(displayModel: movieDetailsDisplayModel)
        
        XCTAssertEqual(sut.test_debug_originalTitleLabel.text, movieDetailsDisplayModel.originalTitle)
        XCTAssertEqual(sut.test_debug_titleLabel.text, movieDetailsDisplayModel.title)
        XCTAssertEqual(sut.test_debug_overviewLabel.text, movieDetailsDisplayModel.overview)
        XCTAssertEqual(sut.test_debug_releaseDateLabel.text, movieDetailsDisplayModel.releaseDate)
        XCTAssertEqual(sut.test_debug_budgetLabel.text, movieDetailsDisplayModel.budget)
        XCTAssertEqual(sut.test_debug_revenueLabel.text, movieDetailsDisplayModel.revenue)
        XCTAssertEqual(sut.test_debug_ratingLabel.text, movieDetailsDisplayModel.ratingText)
    }
    
    func test_changeState_shouldToggleVisibilityForContent() {
        sut.changeState(state: .content)
        
        XCTAssertFalse(sut.test_debug_movieDetailsCardView.isHidden)
        XCTAssertTrue(sut.test_debug_loadingView.isHidden)
        XCTAssertTrue(sut.test_debug_errorView.isHidden)
    }
    
    func test_changeState_shouldToggleVisibilityForLoading() {
        sut.changeState(state: .loading)
        
        XCTAssertTrue(sut.test_debug_movieDetailsCardView.isHidden)
        XCTAssertFalse(sut.test_debug_loadingView.isHidden)
        XCTAssertTrue(sut.test_debug_errorView.isHidden)
    }
    
    func test_changeState_shouldToggleVisibilityForError() {
        sut.changeState(state: .error)
        
        XCTAssertTrue(sut.test_debug_movieDetailsCardView.isHidden)
        XCTAssertTrue(sut.test_debug_loadingView.isHidden)
        XCTAssertFalse(sut.test_debug_errorView.isHidden)
        XCTAssertEqual(
            sut.test_debug_errorView.test_debug_errorLabel,
            String(localized: "requestMovieDetailsError")
        )
    }
}
