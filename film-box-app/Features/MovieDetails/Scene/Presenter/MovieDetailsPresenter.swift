import Foundation

protocol MovieDetailsPresenterLogic {
    func responseMovieDetails(movieDetails: MovieDetailsEntity)
    func responseLoading()
    func responseError()
}

final class MovieDetailsPresenter: MovieDetailsPresenterLogic {
    weak var display: MovieDetailsViewControllerLogic?
    
    func responseMovieDetails(movieDetails: MovieDetailsEntity) {
        let displayModel = MovieDetailsDisplayModel(
            backdropPath: movieDetails.backdropPath,
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
        
        display?.displayMovieDetails(displayModel: displayModel)
    }
    
    func responseLoading() {
        display?.displayLoading()
    }
    
    func responseError() {
        display?.displayError()
    }
}
