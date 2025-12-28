import XCTest
@testable import film_box_app

final class MoviesInteractorTests: XCTestCase {
    let repositorySpy = MoviesRepositorySpy()
    let favoriteMoviesRepositorySpy = FavoriteMoviesRepositorySpy()
    let searchMoviesRepositorySpy = SearchMoviesRepositorySpy()
    let presenterSpy = MoviesPresenterSpy()
    
    var sut: MoviesInteractor!
    
    override func setUp() {
        super.setUp()
        sut = MoviesInteractor(
            repository: repositorySpy,
            favoriteMoviesRepository: favoriteMoviesRepositorySpy,
            searchMoviesRepository: searchMoviesRepositorySpy
        )
        
        sut.presenter = presenterSpy
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_requestSearchMovies_givenSuccess_shouldResponseMovies() {
        repositorySpy.stubbedGetLastMovieSearchResult =  "Movie Title"
        
        let movieEntity = MovieEntity.fixture(id: 99)
        
        repositorySpy.stubbedFetchMovieCompletionResult = .success(
            MoviesResponseEntity.fixture(results: [movieEntity])
        )
        
        favoriteMoviesRepositorySpy.stubbedIsMovieFavoriteResult = true
        
        let exp = expectation(description: "wait async success")
        
        DispatchQueue.main.async { exp.fulfill() }
        
        sut.requestSearchMovies()
        
        wait(for: [exp], timeout: 0.2)
        XCTAssertEqual(presenterSpy.didSearchMoviesCount, 1)
        XCTAssertEqual(presenterSpy.didSearchMoviesParameterMovies.first?.id, movieEntity.id)
        XCTAssertTrue(presenterSpy.didSearchMoviesParameterFavorites.contains(movieEntity.id))
    }
    
    func test_requestSearchMovies_givenFailure_shouldResponseError() {
        repositorySpy.stubbedGetLastMovieSearchResult = "Movie Title"
        repositorySpy.stubbedFetchMovieCompletionResult = .failure(NSError(domain: "test", code: -1))
        
        let exp = expectation(description: "wait async failure")
        DispatchQueue.main.async { exp.fulfill() }
        
        sut.requestSearchMovies()
        
        wait(for: [exp], timeout: 0.2)
        XCTAssertEqual(searchMoviesRepositorySpy.saveLastMovieSearchCount, 1)
        XCTAssertEqual(searchMoviesRepositorySpy.saveLastMovieSearchParameterQuery, "")
        XCTAssertEqual(presenterSpy.didSearchMoviesErrorCount, 1)
    }
    
    func test_requestSearchMovies_givenEmptyQuery_shouldResponseEmpty() {
        repositorySpy.stubbedGetLastMovieSearchResult = ""
        
        sut.requestSearchMovies()
        
        XCTAssertEqual(presenterSpy.didSearchMoviesEmptyCount, 1)
    }
    
    func test_requestSearchMovies_givenValidQuery_givenEmptyResults_shouldResponseError() {
        repositorySpy.stubbedGetLastMovieSearchResult = "Movie Title"
        repositorySpy.stubbedFetchMovieCompletionResult = .success(
            MoviesResponseEntity(page: 1, results: [], totalPages: 1, totalResults: 0)
        )
        
        let exp = expectation(description: "wait async empty results")
        DispatchQueue.main.async { exp.fulfill() }
        
        sut.requestSearchMovies()
        
        wait(for: [exp], timeout: 0.2)
        XCTAssertEqual(searchMoviesRepositorySpy.saveLastMovieSearchCount, 1)
        XCTAssertEqual(searchMoviesRepositorySpy.saveLastMovieSearchParameterQuery, "")
        XCTAssertEqual(presenterSpy.didSearchMoviesErrorCount, 1)
    }
    
    func test_favoriteMovie_shouldFavoriteMovieEntity() {
        let movieDisplayModel = MovieDisplayModel.fixture()
        
        sut.favoriteMovie(movieId: movieDisplayModel.id)
        
        XCTAssertEqual(favoriteMoviesRepositorySpy.favoriteCount, 1)
        XCTAssertEqual(favoriteMoviesRepositorySpy.favoriteParameterFavoriteMovie, 99)
    }
    
    func test_unfavoriteMovie_shouldUnfavoriteMovieEntity() {
        sut.unfavoriteMovie(movieId: 1)
        
        XCTAssertEqual(favoriteMoviesRepositorySpy.unfavoriteCount, 1)
        XCTAssertEqual(favoriteMoviesRepositorySpy.unfavoriteParameterFavoriteMovie, 1)
    }
}
