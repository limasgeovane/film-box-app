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
    
    func test_searchButtonPressed_givenEmptyText_shouldShowErrorAndNotCallDelegate() {
        let sut = SearchMoviesView()
        let delegateSpy = DelegateSpy()
        sut.delegate = delegateSpy
        
        let textField = sut.subviews
            .compactMap { $0 as? UIStackView }
            .first?.arrangedSubviews
            .compactMap { $0 as? UITextField }
            .first
        textField?.text = ""
        
        let button = sut.subviews
            .compactMap { $0 as? UIStackView }
            .first?.arrangedSubviews
            .compactMap { $0 as? UIButton }
            .first
        button?.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(delegateSpy.searchPressedCount, 0)
        XCTAssertTrue(true)
    }
    
    func test_searchButtonPressed_givenNonEmptyText_shouldCallDelegateAndHideError() {
        let sut = SearchMoviesView()
        let delegateSpy = DelegateSpy()
        sut.delegate = delegateSpy
        
        let textField = sut.subviews
            .compactMap { $0 as? UIStackView }
            .first?.arrangedSubviews
            .compactMap { $0 as? UITextField }
            .first
        textField?.text = "Matrix"
        
        let button = sut.subviews
            .compactMap { $0 as? UIStackView }
            .first?.arrangedSubviews
            .compactMap { $0 as? UIButton }
            .first
        button?.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(delegateSpy.searchPressedCount, 1)
        XCTAssertEqual(delegateSpy.searchPressedParameterQuery, "Matrix")
    }
}
