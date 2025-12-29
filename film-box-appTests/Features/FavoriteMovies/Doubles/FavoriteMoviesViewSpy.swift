import UIKit
@testable import film_box_app

final class FavoriteMoviesViewSpy: UIView, FavoriteMoviesViewLogic {
    private(set) var delegateSetterCount = 0
    private(set) var delegateGetterCount = 0
    private(set) var invokedDelegate: FavoriteMoviesViewDelegate?
    private var stubbedDelegate: FavoriteMoviesViewDelegate?
    
    var delegate: FavoriteMoviesViewDelegate? {
        get {
            delegateGetterCount += 1
            return stubbedDelegate
        }
        set {
            delegateSetterCount += 1
            invokedDelegate = newValue
        }
    }
    
    private(set) var favoriteMoviesSetterCount = 0
    private(set) var favoriteMoviesGetterCount = 0
    private(set) var invokedFavoriteMoviesMovies: [FavoriteMoviesDisplayModel] = []
    private var stubbedFavoriteMovies: [FavoriteMoviesDisplayModel] = []
    var favoriteMovies: [FavoriteMoviesDisplayModel] {
        get {
            favoriteMoviesSetterCount += 1
            return stubbedFavoriteMovies
        }
        set {
            favoriteMoviesSetterCount += 1
            invokedFavoriteMoviesMovies = newValue
        }
    }
    
    private(set) var changeStateCount = 0
    private(set) var changeStateParameterState: FavoriteMoviesView.State?
    func changeState(state: FavoriteMoviesView.State) {
        changeStateCount += 1
        changeStateParameterState = state
    }
}
