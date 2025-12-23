import Foundation

protocol MovieDetailsPresenterInputLogic {
    func requestMovieDetails(movieId: Int)
}

protocol MovieDetailsPresenterOutputLogic: AnyObject {
    func didRequestMovieDetails(movieDetails: MovieDetailsEntity)
    func didRequestMovieDetailsError()
}

final class MovieDetailsPresenter {
    weak var viewController: MovieDetailsViewControllerLogic?
    
    var interactor: MovieDetailsInteractorLogic
    
    init(interactor: MovieDetailsInteractorLogic) {
        self.interactor = interactor
    }
}

extension MovieDetailsPresenter: MovieDetailsPresenterInputLogic {
    func requestMovieDetails(movieId: Int) {
        viewController?.displayLoading()
        interactor.requestMovieDetails(movieId: movieId)
    }
}

extension MovieDetailsPresenter: MovieDetailsPresenterOutputLogic {
    func didRequestMovieDetails(movieDetails: MovieDetailsEntity) {
        let displayModel = MovieDetailsDisplayModel(
            backdropPath: {
                if let backdropPath = movieDetails.backdropPath, !backdropPath.isEmpty {
                    return "https://image.tmdb.org/t/p/w780\(backdropPath)"
                } else {
                    return ""
                }
            }(),
            originalTitle: movieDetails.originalTitle,
            title: movieDetails.title,
            overview: {
                if let overview = movieDetails.overview, !overview.isEmpty {
                    return overview
                } else {
                    return (String(localized: "noOverviewAvailable"))
                }
            }(),
            releaseDate: "\(movieDetails.releaseDate.usLongDate)",
            budget: {
                if let budget = movieDetails.budget, budget > 0 {
                    return "\(String(localized: "budget")): \(budget.usdFormatter)"
                } else {
                    return ""
                }
            }(),
            revenue: {
                if let revenue = movieDetails.budget, revenue > 0 {
                    return "\(String(localized: "revenue")): \(revenue.usdFormatter)"
                } else {
                    return ""
                }
            }(),
            ratingText: {
                if let rating = movieDetails.voteAverage, rating > 0 {
                    return "\(String(localized: "movieRating")): \(String(format: "%.1f", rating))"
                } else {
                    return String(localized: "unrated")
                }
            }()
        )
        
        viewController?.displayContent(displayModel: displayModel)
    }
    
    func didRequestMovieDetailsError() {
        viewController?.displayError()
    }
}
