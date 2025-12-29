@testable import film_box_app

final class FavoriteMoviesViewControllerSpy: FavoriteMoviesViewControllerLogic {
    private(set) var displayLoadingCount = 0
    func displayLoading() {
        displayLoadingCount += 1
    }
    
    private(set) var displayContentCount = 0
    private(set) var displayContentParameter: [FavoriteMoviesDisplayModel] = []
    func displayContent(displayModel: [FavoriteMoviesDisplayModel]) {
        displayContentCount += 1
        displayContentParameter = displayModel
    }
    
    private(set) var displayEmptyStateCount = 0
    func displayEmptyState() {
        displayEmptyStateCount += 1
    }
    
    private(set) var displayErrorCount = 0
    func displayError() {
        displayErrorCount += 1
    }
}
