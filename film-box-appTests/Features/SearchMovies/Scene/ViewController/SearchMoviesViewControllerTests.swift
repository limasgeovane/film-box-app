import XCTest
@testable import film_box_app

final class SearchMoviesViewControllerTests: XCTestCase {
    var presenterSpy: SearchMoviesPresenterSpy!
    var contentViewSpy: SearchMoviesViewSpy!
    var sut: SearchMoviesViewController!
    
    override func setUp() {
        super.setUp()
        presenterSpy = SearchMoviesPresenterSpy()
        contentViewSpy = SearchMoviesViewSpy()
        sut = SearchMoviesViewController(
            presenter: presenterSpy,
            contentView: contentViewSpy
        )
    }
    
    override func tearDown() {
        sut = nil
        presenterSpy = nil
        contentViewSpy = nil
        super.tearDown()
    }
    
    func test_loadView_shouldSetView() {
        sut.loadView()
        
        XCTAssertTrue(sut.view is SearchMoviesViewLogic)
    }
    
    func test_viewDidLoad_shouldSetTitleDelegateAndDisplayContent() {
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.title, String(localized: "searchMoviesTitle"))
        XCTAssertEqual(contentViewSpy.delegateSetterCount, 1)
        XCTAssertTrue(contentViewSpy.invokedDelegate is SearchMoviesViewController)
        XCTAssertEqual(contentViewSpy.changeStateCount, 1)
        XCTAssertEqual(contentViewSpy.changeStateParameterState, .content)
    }
    
    func test_viewDidAppear_shouldFocusSearch() {
        sut.loadView()
        sut.viewDidAppear(false)
        
        XCTAssertEqual(contentViewSpy.focusSearchCount, 1)
    }
    
    func test_searchPressed_givenEmptyQuery_shouldShowErrorState() {
        sut.searchPressed(query: "")
        
        XCTAssertEqual(contentViewSpy.changeStateCount, 1)
        XCTAssertEqual(contentViewSpy.changeStateParameterState, .error)
        XCTAssertEqual(presenterSpy.openMoviesCount, 0)
    }
    
    func test_searchPressed_givenValidQuery_shouldCallPresenter() {
        sut.searchPressed(query: "Inception")
        
        XCTAssertEqual(presenterSpy.openMoviesCount, 1)
        XCTAssertEqual(presenterSpy.openMoviesParameterQuery, "Inception")
        XCTAssertEqual(contentViewSpy.changeStateCount, 0) // não muda estado aqui
    }
}
