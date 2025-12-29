@testable import film_box_app

final class SearchMoviesViewControllerSpy: SearchMoviesViewControllerLogic {
    private(set) var displayContentCount = 0
    func displayContent() {
        displayContentCount += 0
    }
}
