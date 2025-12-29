import XCTest
@testable import film_box_app

final class FavoriteMoviesInteractorTests: XCTestCase {
    let repositorySpy = FavoriteMoviesRepositorySpy()
    let movieDetailsRepositorySpy = MovieDetailsRepositorySpy()
    let presenterSpy = FavoriteMoviesPresenterSpy()
    
    var sut: FavoriteMoviesInteractor!
    
    override func setUp() {
        super.setUp()
        sut = FavoriteMoviesInteractor(
            repository: repositorySpy,
            movieDetailsRepository: movieDetailsRepositorySpy
        )
        sut.presenter = presenterSpy
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_requestFavoriteMovies_givenEmptyFavorites_shouldResponseEmpty() {
        repositorySpy.stubbedGetFavoritesResult = []
        
        sut.requestFavoriteMovies()
        
        XCTAssertEqual(repositorySpy.getFavoritesCount, 1)
        XCTAssertEqual(presenterSpy.didRequestFavoriteMoviesEmptyCount, 1)
    }
    
    func test_requestFavoriteMovies_givenSuccess_shouldResponseMovies() {
        repositorySpy.stubbedGetFavoritesResult = [99]
        
        let movieDetails = MovieDetailsEntity.fixture(id: 99)
        movieDetailsRepositorySpy.stubbedFetchMovieDetailsResult = .success(movieDetails)
        
        let exp = expectation(description: "wait async success")
        DispatchQueue.main.async { exp.fulfill() }
        
        sut.requestFavoriteMovies()
        
        wait(for: [exp], timeout: 0.2)
        XCTAssertEqual(movieDetailsRepositorySpy.fetchMovieDetailsCount, 1)
        XCTAssertEqual(movieDetailsRepositorySpy.fetchMovieDetailsParameterId, 99)
        XCTAssertEqual(presenterSpy.didRequestFavoriteMoviesCount, 1)
        XCTAssertEqual(presenterSpy.didRequestFavoriteMoviesParameter.first?.id, 99)
    }
    
    func test_requestFavoriteMovies_givenFailure_shouldResponseError() {
        repositorySpy.stubbedGetFavoritesResult = [99]
        movieDetailsRepositorySpy.stubbedFetchMovieDetailsResult = .failure(NSError(domain: "test", code: -1))
        
        let exp = expectation(description: "wait async failure")
        DispatchQueue.main.async { exp.fulfill() }
        
        sut.requestFavoriteMovies()
        
        wait(for: [exp], timeout: 0.2)
        XCTAssertEqual(movieDetailsRepositorySpy.fetchMovieDetailsCount, 1)
        XCTAssertEqual(presenterSpy.didRequestFavoriteMoviesErrorCount, 1)
    }
    
    func test_unfavoriteMovie_shouldUnfavoriteAndFetchFavorites() {
        repositorySpy.stubbedGetFavoritesResult = []
        
        sut.unfavoriteMovie(movieId: 1)
        
        XCTAssertEqual(repositorySpy.unfavoriteCount, 1)
        XCTAssertEqual(repositorySpy.unfavoriteParameterFavoriteMovie, 1)
        XCTAssertEqual(repositorySpy.getFavoritesCount, 1)
        XCTAssertEqual(presenterSpy.didRequestFavoriteMoviesEmptyCount, 1)
    }
}
