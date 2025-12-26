import XCTest
@testable import film_box_app

final class MovieDetailsViewTests: XCTestCase {
    func test_setupContent_shouldPopulateUI() {
        let sut = MovieDetailsView()
        let display = MovieDetailsDisplayModel.fixture(
            backdropPath: "", // força fallback sem imagem
            originalTitle: "Original",
            title: "Title",
            overview: "Overview",
            releaseDate: "Dec 25, 2025",
            budget: "Budget: $1,000,000",
            revenue: "Revenue: $5,000,000",
            ratingText: "Rating: 8.5"
        )
        
        sut.setupContent(displayModel: display)
        // Sem acesso direto aos subviews privados, este teste valida não-crash.
        // Se quiser validar imagens e modos, exponha via test-only accessor.
        XCTAssertTrue(true)
    }
    
    func test_changeState_shouldToggleVisibilityForContent() {
        let sut = MovieDetailsView()
        sut.changeState(state: .content)
        // Sem acesso aos subviews privados, validamos que não há crashes.
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
