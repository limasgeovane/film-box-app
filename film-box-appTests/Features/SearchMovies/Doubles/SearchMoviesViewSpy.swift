import UIKit
@testable import film_box_app

final class SearchMoviesViewSpy: UIView, SearchMoviesViewLogic {
    private(set) var delegateSetterCount = 0
    private(set) var delegateGetterCount = 0
    private(set) var invokedDelegate: SearchMoviesViewDelegate?
    private var stubbedDelegate: SearchMoviesViewDelegate?
    
    var delegate: SearchMoviesViewDelegate? {
        get {
            delegateGetterCount += 1
            return stubbedDelegate
        }
        set {
            delegateSetterCount += 1
            invokedDelegate = newValue
        }
    }
    
    private(set) var focusSearchCount = 0
    func focusSearch() {
        focusSearchCount += 1
    }
    
    private(set) var changeStateCount = 0
    private(set) var changeStateParameterState: SearchMoviesView.State?
    func changeState(state: SearchMoviesView.State) {
        changeStateCount += 1
        changeStateParameterState = state
    }
}
