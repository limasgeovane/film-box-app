import XCTest
@testable import film_box_app

final class MovieDetailsInteractorTests: XCTestCase {
    let presenterSpy = MovieDetailsPresenterSpy()
    let repositorySpy = MovieDetailsRepositorySpy()
    let favoriteMoviesRepositorySpy = FavoriteMoviesRepositorySpy()
    
    var sut: MovieDetailsInteractor!
    
    override func setUp() {
        super.setUp()
        sut = MovieDetailsInteractor(
            repository: repositorySpy,
            favoriteMoviesRepository: favoriteMoviesRepositorySpy
        )
        
        sut.presenter = presenterSpy
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_requestMovieDetails_givenSuccess_shouldCallPresenterWithMovieDetails() {
        let movieDetailsEntity = MovieDetailsEntity.fixture()
        repositorySpy.stubbedFetchMovieDetailsResult = .success(movieDetailsEntity)
        
        let exp = expectation(description: "wait async success")
        
        DispatchQueue.main.async { exp.fulfill() }
        
        sut.requestMovieDetails(movieId: 99)
        
        wait(for: [exp], timeout: 0.2)
        XCTAssertEqual(repositorySpy.fetchMovieDetailsCount, 1)
        XCTAssertEqual(repositorySpy.fetchMovieDetailsParameterId, 99)
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
        let movieDetailsDisplayModel = MovieDetailsDisplayModel.fixture(id: 99)
        
        sut.favoriteMovie(movieId: movieDetailsDisplayModel.id)
        
        XCTAssertEqual(favoriteMoviesRepositorySpy.favoriteCount, 1)
        XCTAssertEqual(favoriteMoviesRepositorySpy.favoriteParameterFavoriteMovie, 99)
    }
    
    func test_unfavoriteMovie_shouldCallFavoriteMoviesRepository() {
        sut.unfavoriteMovie(movieId: 99)
        
        XCTAssertEqual(favoriteMoviesRepositorySpy.unfavoriteCount, 1)
        XCTAssertEqual(favoriteMoviesRepositorySpy.unfavoriteParameterFavoriteMovie, 99)
    }
    
    func test_isMovieFavorite_givenTrue_shouldReturnTrue() {
        favoriteMoviesRepositorySpy.stubbedIsMovieFavoriteResult = true
        
        let result = sut.isMovieFavorite(movieId: 99)
        
        XCTAssertEqual(favoriteMoviesRepositorySpy.isMovieFavoriteCount, 1)
        XCTAssertEqual(favoriteMoviesRepositorySpy.isMovieFavoriteParameterInt, 99)
        XCTAssertTrue(result)
    }
    
    func test_isMovieFavorite_givenFalse_shouldReturnFalse() {
        favoriteMoviesRepositorySpy.stubbedIsMovieFavoriteResult = false
        
        let result = sut.isMovieFavorite(movieId: 99)
        
        XCTAssertEqual(favoriteMoviesRepositorySpy.isMovieFavoriteCount, 1)
        XCTAssertEqual(favoriteMoviesRepositorySpy.isMovieFavoriteParameterInt, 99)
        XCTAssertFalse(result)
    }
}
