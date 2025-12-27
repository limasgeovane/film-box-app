import XCTest
@testable import film_box_app

final class SearchMoviesViewTests: XCTestCase {
    final class DelegateSpy: SearchMoviesViewDelegate {
        private(set) var searchPressedCount = 0
        private(set) var searchPressedParameterQuery: String?
        
        func searchPressed(query: String) {
            searchPressedCount += 1
            searchPressedParameterQuery = query
        }
    }
    
    var sut: SearchMoviesView!
    var delegateSpy: DelegateSpy!
    
    override func setUp() {
        super.setUp()
        sut = SearchMoviesView()
        delegateSpy = DelegateSpy()
        sut.delegate = delegateSpy
    }
    
    override func tearDown() {
        sut = nil
        delegateSpy = nil
        super.tearDown()
    }
    
    func test_searchButtonPressed_givenNonEmptyText_shouldCallDelegate() {
        sut.testTextField.text = "Movie Title"
        sut.testButton.sendActions(for: .touchUpInside)

        XCTAssertEqual(delegateSpy.searchPressedCount, 1)
        XCTAssertEqual(delegateSpy.searchPressedParameterQuery, "Movie Title")
    }
}
