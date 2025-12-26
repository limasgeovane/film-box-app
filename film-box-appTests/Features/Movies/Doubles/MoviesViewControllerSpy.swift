@testable import film_box_app

final class MoviesViewControllerSpy: MoviesViewControllerLogic {
    private(set) var displayLoadingCount = 0
    func displayLoading() {
        displayLoadingCount += 1
    }
    
    private(set) var displayEmptyViewCount = 0
    func displayEmptyView() {
        displayEmptyViewCount += 1
    }
    
    private(set) var displayContentCount = 0
    private(set) var displayContentParameterMovies: [MovieDisplayModel] = []
    func displayContent(movies: [MovieDisplayModel]) {
        displayContentCount += 1
        displayContentParameterMovies = movies
    }
    
    private(set) var displayErrorCount = 0
    func displayError() {
        displayErrorCount += 1
    }
}
