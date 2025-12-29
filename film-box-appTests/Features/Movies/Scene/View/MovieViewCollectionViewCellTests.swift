import XCTest
@testable import film_box_app

final class MovieViewCollectionViewCellTests: XCTestCase {
    private var sut: MovieViewCollectionViewCell!
    
    override func setUp() {
        super.setUp()
        sut = MovieViewCollectionViewCell(frame: .zero)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_configureCell_shouldSetTextsAndUseCorrectPosterPath() {
        let displayModel = MovieDisplayModel.fixture()
        
        sut.configureCell(displayModel: displayModel)
        
        XCTAssertEqual(sut.test_debug_titleLabel.text, displayModel.title)
        XCTAssertEqual(sut.test_debug_ratingLabel.text, displayModel.ratingText)
        XCTAssertEqual(sut.test_debug_overviewLabel.text, displayModel.overview)
        XCTAssertEqual(displayModel.posterImagePath, "\(Constants.TmdbAPI.tmdbImageURL)/posterPath.jpg")
    }
}
