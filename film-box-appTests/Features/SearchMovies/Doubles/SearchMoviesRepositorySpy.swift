@testable import film_box_app

final class SearchMoviesRepositorySpy: SearchMoviesRepositoryLogic {
    private(set) var saveLastMovieSearchCount = 0
    private(set) var saveLastMovieSearchParameterQuery: String?
    func saveLastMovieSearch(query: String) {
        saveLastMovieSearchCount += 1
        saveLastMovieSearchParameterQuery = query
    }
}
