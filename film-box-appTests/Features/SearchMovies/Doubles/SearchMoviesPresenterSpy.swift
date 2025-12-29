@testable import film_box_app

final class SearchMoviesPresenterSpy: SearchMoviesPresenterInputLogic {
    private(set) var openMoviesCount = 0
    private(set) var openMoviesParameterQuery: String?
    func openMovies(query: String) {
        openMoviesCount += 1
        openMoviesParameterQuery = query
    }
}
