@testable import film_box_app
import UIKit

final class MoviesViewSpy: UIView, MoviesViewLogic {
    private(set) var delegateSetterCount = 0
    private(set) var delegateGetterCount = 0
    private(set) var invokedDelegate: MoviesViewDelegate?
    var stubbedDelegate: MoviesViewDelegate?
    
    var delegate: MoviesViewDelegate? {
        get {
            delegateGetterCount += 1
            return stubbedDelegate
        }
        set {
            delegateSetterCount += 1
            invokedDelegate = newValue
        }
    }
    
    private(set) var moviesSetterCount = 0
    private(set) var moviesGetterCount = 0
    private(set) var invokedMovies: [MovieDisplayModel] = []
    var stubbedMovies: [MovieDisplayModel] = []
    var movies: [MovieDisplayModel] {
        get {
            moviesGetterCount += 1
            return stubbedMovies
        }
        set {
            moviesSetterCount += 1
            invokedMovies = newValue
        }
    }
    
    private(set) var reloadMovieCellCount = 0
    private(set) var reloadMovieCellParameterIndex: Int?
    func reloadMovieCell(index: Int) {
        reloadMovieCellCount += 1
        reloadMovieCellParameterIndex = index
    }
    
    private(set) var changeStateCount = 0
    private(set) var changeStateParameterState: MoviesView.State?
    func changeState(state: MoviesView.State) {
        changeStateCount += 1
        changeStateParameterState = state
    }
}
