import UIKit
@testable import film_box_app

final class MovieDetailsViewSpy: UIView, MovieDetailsViewLogic {
    private(set) var setupContentCount = 0
    private(set) var setupContentParameter: MovieDetailsDisplayModel?
    func setupContent(displayModel: MovieDetailsDisplayModel) {
        setupContentCount += 1
        setupContentParameter = displayModel
    }
    
    private(set) var changeStateCount = 0
    private(set) var changeStateParameterState: MovieDetailsView.State?
    func changeState(state: MovieDetailsView.State) {
        changeStateCount += 1
        changeStateParameterState = state
    }
}
