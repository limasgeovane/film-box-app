@testable import film_box_app

final class SearchMoviesRouterSpy: SearchMoviesRouterLogic {
    private(set) var popMoviesCount = 0
    func popMovies() {
        popMoviesCount += 1
    }
}
