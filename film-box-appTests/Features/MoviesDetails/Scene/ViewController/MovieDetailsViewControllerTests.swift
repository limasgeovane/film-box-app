import XCTest
@testable import film_box_app

final class MovieDetailsViewControllerTests: XCTestCase {
    let presenterSpy = MovieDetailsPresenterSpy()
    let contentViewSpy = MovieDetailsViewSpy()
    
    lazy var sut = MovieDetailsViewController(
        presenter: presenterSpy,
        contentView: contentViewSpy,
        movieId: 77
    )
    
    func test_loadView_shouldSetView() {
        sut.loadView()
        
        XCTAssertTrue(sut.view is MovieDetailsViewLogic)
    }
    
    func test_viewWillAppear_shouldRequestDetails() {
        sut.loadViewIfNeeded()
        sut.viewWillAppear(false)
        
        XCTAssertEqual(presenterSpy.requestMovieDetailsCount, 1)
        XCTAssertEqual(presenterSpy.requestMovieDetailsParameterId, 77)
    }
    
    func test_displayLoading_shouldHideFavoriteAndShowLoading() {
        sut.displayLoading()
        
        XCTAssertEqual(contentViewSpy.changeStateCount, 1)
        XCTAssertEqual(contentViewSpy.changeStateParameterState, .loading)
        XCTAssertNil(sut.navigationItem.rightBarButtonItem)
    }
    
    func test_displayContent_shouldSetupAndShowContent() {
        let displayModel = MovieDetailsDisplayModel.fixture()
        
        sut.displayContent(displayModel: displayModel)
        
        XCTAssertEqual(contentViewSpy.setupContentCount, 1)
        XCTAssertEqual(contentViewSpy.setupContentParameter?.title, displayModel.title)
        XCTAssertEqual(contentViewSpy.changeStateCount, 1)
        XCTAssertEqual(contentViewSpy.changeStateParameterState, .content)
    }
    
    func test_displayError_shouldShowErrorState() {
        sut.displayError()
        
        XCTAssertEqual(contentViewSpy.changeStateCount, 1)
        XCTAssertEqual(contentViewSpy.changeStateParameterState, .error)
        XCTAssertNil(sut.navigationItem.rightBarButtonItem)
    }
}
