@testable import film_box_app
import UIKit

final class MovieDetailsViewControllerSpy: MovieDetailsViewControllerLogic {
    private(set) var displayLoadingCount = 0
    func displayLoading() {
        displayLoadingCount += 1
    }
    
    private(set) var displayContentCount = 0
    private(set) var displayContentParameter: MovieDetailsDisplayModel?
    func displayContent(displayModel: MovieDetailsDisplayModel) {
        displayContentCount += 1
        displayContentParameter = displayModel
    }
    
    private(set) var displayErrorCount = 0
    func displayError() {
        displayErrorCount += 1
    }
}
