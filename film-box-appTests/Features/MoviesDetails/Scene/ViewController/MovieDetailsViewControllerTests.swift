import XCTest
@testable import film_box_app

final class MovieDetailsViewControllerTests: XCTestCase {
    private let presenterSpy = MovieDetailsPresenterSpy()
    private let contentViewSpy = MovieDetailsViewSpy()
    
    private var sut: MovieDetailsViewController!
    
    override func setUp() {
        super.setUp()
        sut = MovieDetailsViewController(
            presenter: presenterSpy,
            contentView: contentViewSpy,
            movieId: 99
        )
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_loadView_shouldSetView() {
        sut.loadView()
        
        XCTAssertTrue(sut.view is MovieDetailsViewLogic)
    }
    
    func test_viewWillAppear_shouldRequestDetails() {
        sut.loadView()
        sut.viewWillAppear(false)
        
        XCTAssertEqual(presenterSpy.requestMovieDetailsCount, 1)
        XCTAssertEqual(presenterSpy.requestMovieDetailsParameterId, 99)
    }
    
    func test_displayLoading_shouldShowLoading() {
        sut.displayLoading()
        
        XCTAssertEqual(contentViewSpy.changeStateCount, 1)
        XCTAssertEqual(contentViewSpy.changeStateParameterState, .loading)
        XCTAssertNil(sut.navigationItem.rightBarButtonItem)
    }
    
    func test_displayContent_shouldShowContent() {
        let movieDetailsDisplayModel = MovieDetailsDisplayModel.fixture()
        
        sut.displayContent(displayModel: movieDetailsDisplayModel)
        
        XCTAssertEqual(contentViewSpy.setupContentCount, 1)
        XCTAssertEqual(contentViewSpy.setupContentParameter?.title, movieDetailsDisplayModel.title)
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
