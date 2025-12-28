import XCTest
@testable import film_box_app

final class MovieDetailsRequestConfigurationTests: XCTestCase {
    var sut: MovieDetailsRequestConfiguration!
    
    override func setUp() {
        super.setUp()
        sut = MovieDetailsRequestConfiguration(movieId: 99)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_path_shouldBeMovieIdPath() {
        XCTAssertEqual(sut.path, "/movie/99")
    }
    
    func test_parameters_shouldContainLanguage() {
        XCTAssertEqual(sut.parameters["language"] as? String, Constants.TmdbAPI.language)
    }
    
    func test_headers_shouldContainBearerToken() {
        XCTAssertEqual(sut.headers["Authorization"], "Bearer \(NetworkAuthorization.bearerToken)")
    }
}
