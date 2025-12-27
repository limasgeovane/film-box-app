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
    
    func test_favoriteMovie_shouldCallFavoriteMoviesRepository() {
        let movie = MovieDetailsDisplayModel.fixture(id: 42)
        
        sut.favoriteMovie(movie: movie)
        
        XCTAssertEqual(favoriteMoviesRepositorySpy.favoriteCount, 1)
        XCTAssertEqual(favoriteMoviesRepositorySpy.favoriteParameterFavoriteMovie, 42)
    }
    
    func test_unfavoriteMovie_shouldCallFavoriteMoviesRepository() {
        sut.unfavoriteMovie(movieId: 99)
        
        XCTAssertEqual(favoriteMoviesRepositorySpy.unfavoriteCount, 1)
        XCTAssertEqual(favoriteMoviesRepositorySpy.unfavoriteParameterFavoriteMovie, 99)
    }
    
    func test_isMovieFavorite_givenTrue_shouldReturnTrue() {
        favoriteMoviesRepositorySpy.stubbedIsMovieFavoriteResult = true
        
        let result = sut.isMovieFavorite(movieId: 7)
        
        XCTAssertEqual(favoriteMoviesRepositorySpy.isMovieFavoriteCount, 1)
        XCTAssertEqual(favoriteMoviesRepositorySpy.isMovieFavoriteParameterInt, 7)
        XCTAssertTrue(result)
    }
    
    func test_isMovieFavorite_givenFalse_shouldReturnFalse() {
        favoriteMoviesRepositorySpy.stubbedIsMovieFavoriteResult = false
        
        let result = sut.isMovieFavorite(movieId: 8)
        
        XCTAssertEqual(favoriteMoviesRepositorySpy.isMovieFavoriteCount, 1)
        XCTAssertEqual(favoriteMoviesRepositorySpy.isMovieFavoriteParameterInt, 8)
        XCTAssertFalse(result)
    }
}
