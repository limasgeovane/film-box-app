import XCTest
@testable import film_box_app

final class MoviesRequestConfigurationTests: XCTestCase {
    var sut = MoviesRequestConfiguration(query: "Avatar")
    
    func test_path_shouldBeSearchMovie() {
        XCTAssertEqual(sut.path, "/search/movie")
    }
    
    func test_parameters_shouldContainQueryAndLanguage() {
        XCTAssertEqual(sut.parameters["query"] as? String, "Avatar")
        XCTAssertEqual(sut.parameters["language"] as? String, Constants.TmdbAPI.language)
    }
    
    func test_headers_shouldContainBearerToken() {
        XCTAssertEqual(sut.headers["Authorization"], "Bearer \(NetworkAuthorization.bearerToken)")
    }
}
