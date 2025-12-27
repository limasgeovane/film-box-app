import XCTest
@testable import film_box_app

final class MoviesInteractorTests: XCTestCase {
    let repositorySpy = MoviesRepositorySpy()
    let favoriteMoviesRepositorySpy = FavoriteMoviesRepositorySpy()
    let searchMoviesRepositorySpy = SearchMoviesRepositorySpy()
    let presenterSpy = MoviesPresenterSpy()
    
    lazy var sut = MoviesInteractor(
        repository: repositorySpy,
        favoriteMoviesRepository: favoriteMoviesRepositorySpy,
        searchMoviesRepository: searchMoviesRepositorySpy
    )
    
    override func setUp() {
        super.setUp()
        sut.presenter = presenterSpy
    }
    
    func test_requestSearchMovies_givenEmptyQuery_shouldResponseEmpty() {
        repositorySpy.stubbedGetLastMovieSearchResult = ""
        
        sut.requestSearchMovies()
        
        XCTAssertEqual(presenterSpy.didSearchMoviesEmptyCount, 1)
    }
    
    func test_requestSearchMovies_givenValidQuery_givenEmptyResults_shouldResponseError() {
        repositorySpy.stubbedGetLastMovieSearchResult = "Batman"
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
    
    func test_requestSearchMovies_givenValidQuery_givenSuccess_shouldResponseMovies() {
        repositorySpy.stubbedGetLastMovieSearchResult = "Inception"
        let movie = MovieEntityFixture.makeMovie(id: 1)
        repositorySpy.stubbedFetchMovieCompletionResult = .success(
            MovieEntityFixture.makeResponse(results: [movie])
        )
        favoriteMoviesRepositorySpy.stubbedIsMovieFavoriteResult = true
        
        let exp = expectation(description: "wait async success")
        DispatchQueue.main.async { exp.fulfill() }
        
        sut.requestSearchMovies()
        
        wait(for: [exp], timeout: 0.2)
        XCTAssertEqual(presenterSpy.didSearchMoviesCount, 1)
        XCTAssertEqual(presenterSpy.didSearchMoviesParameterMovies.first?.id, movie.id)
        XCTAssertTrue(presenterSpy.didSearchMoviesParameterFavorites.contains(movie.id))
    }
    
    func test_requestSearchMovies_givenFailure_shouldResponseError() {
        repositorySpy.stubbedGetLastMovieSearchResult = "Matrix"
        repositorySpy.stubbedFetchMovieCompletionResult = .failure(NSError(domain: "test", code: -1))
        
        let exp = expectation(description: "wait async failure")
        DispatchQueue.main.async { exp.fulfill() }
        
        sut.requestSearchMovies()
        
        wait(for: [exp], timeout: 0.2)
        XCTAssertEqual(searchMoviesRepositorySpy.saveLastMovieSearchCount, 1)
        XCTAssertEqual(searchMoviesRepositorySpy.saveLastMovieSearchParameterQuery, "")
        XCTAssertEqual(presenterSpy.didSearchMoviesErrorCount, 1)
    }
        
    func test_favoriteMovie_shouldFavoriteMovieEntity() {
        let movieDisplay = MovieDisplayModel.fixture(
            id: 1,
            posterImagePath: "\(Constants.TmdbAPI.tmdbImageURL)/poster.jpg",
            title: "Interstellar",
            ratingText: "8.5",
            overview: "Space travel"
        )
        
        sut.favoriteMovie(movie: movieDisplay)
        
        XCTAssertEqual(favoriteMoviesRepositorySpy.favoriteCount, 1)
        XCTAssertEqual(favoriteMoviesRepositorySpy.favoriteParameterFavoriteMovie, 1)
    }
        
    func test_unfavoriteMovie_shouldUnfavoriteMovieEntity() {
        sut.unfavoriteMovie(movieId: 1)
        
        XCTAssertEqual(favoriteMoviesRepositorySpy.unfavoriteCount, 1)
        XCTAssertEqual(favoriteMoviesRepositorySpy.unfavoriteParameterFavoriteMovie, 1)
    }
}
