import XCTest
@testable import film_box_app

final class MovieDetailsInteractorTests: XCTestCase {
    let presenterSpy = MovieDetailsPresenterSpy()
    
    let repositorySpy = MovieDetailsRepositorySpy()
    let favoriteMoviesRepositorySpy = FavoriteMoviesRepositorySpy()
    
    lazy var sut = MovieDetailsInteractor(
        repository: repositorySpy,
        favoriteMoviesRepository: favoriteMoviesRepositorySpy
    )
    
    override func setUp() {
        super.setUp()
        sut.presenter = presenterSpy
    }
    
    func test_requestMovieDetails_givenSuccess_shouldCallPresenterWithMovieDetails() {
        let movieDetails = MovieDetailsEntityFixture.make()
        repositorySpy.stubbedFetchMovieDetailsResult = .success(movieDetails)
        
        let exp = expectation(description: "wait async success")
        DispatchQueue.main.async { exp.fulfill() }
        
        sut.requestMovieDetails(movieId: 1)
        
        wait(for: [exp], timeout: 0.2)
        XCTAssertEqual(repositorySpy.fetchMovieDetailsCount, 1)
        XCTAssertEqual(repositorySpy.fetchMovieDetailsParameterId, 1)
        XCTAssertEqual(presenterSpy.didRequestMovieDetailsCount, 1)
        XCTAssertEqual(presenterSpy.didRequestMovieDetailsParameter?.title, "Movie Title")
    }
    
    func test_requestMovieDetails_givenFailure_shouldCallPresenterError() {
        repositorySpy.stubbedFetchMovieDetailsResult = .failure(NSError(domain: "test", code: -1))
        
        let exp = expectation(description: "wait async failure")
        DispatchQueue.main.async { exp.fulfill() }
        
        sut.requestMovieDetails(movieId: 99)
        
        wait(for: [exp], timeout: 0.2)
        XCTAssertEqual(repositorySpy.fetchMovieDetailsCount, 1)
        XCTAssertEqual(repositorySpy.fetchMovieDetailsParameterId, 99)
        XCTAssertEqual(presenterSpy.didRequestMovieDetailsErrorCount, 1)
    }
}
