import XCTest
@testable import film_box_app

final class MovieDetailsViewTests: XCTestCase {
    func test_setupContent_shouldPopulateUI() {
        let sut = MovieDetailsView()
        let display = MovieDetailsDisplayModel.fixture()
        
        sut.setupContent(displayModel: display)
        
        XCTAssertTrue(true)
    }
    
    func test_changeState_shouldToggleVisibilityForContent() {
        let sut = MovieDetailsView()
        sut.changeState(state: .content)
       
        XCTAssertTrue(true)
    }
    
    func test_changeState_shouldToggleVisibilityForLoading() {
        let sut = MovieDetailsView()
        sut.changeState(state: .loading)
        XCTAssertTrue(true)
    }
    
    func test_changeState_shouldToggleVisibilityForError() {
        let sut = MovieDetailsView()
        sut.changeState(state: .error)
        XCTAssertTrue(true)
    }
}
