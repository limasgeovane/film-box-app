import Foundation

protocol MovieDetailsPresenterInputLogic {
    func requestMovieDetails(movieId: Int)
    func didTapFavorite(movieId: Int, isFavorite: Bool)
}

protocol MovieDetailsPresenterOutputLogic: AnyObject {
    func didRequestMovieDetails(movieDetails: MovieDetailsEntity)
    func didRequestMovieDetailsError()
}

final class MovieDetailsPresenter {
    weak var viewController: MovieDetailsViewControllerLogic?
    
    private var displayModel: MovieDetailsDisplayModel?
    private let interactor: MovieDetailsInteractorLogic

    init(interactor: MovieDetailsInteractorLogic) {
        self.interactor = interactor
    }
}

extension MovieDetailsPresenter: MovieDetailsPresenterInputLogic {
    func requestMovieDetails(movieId: Int) {
        viewController?.displayLoading()
        interactor.requestMovieDetails(movieId: movieId)
    }
    
    func didTapFavorite(movieId: Int, isFavorite: Bool) {
        if isFavorite {
            interactor.favoriteMovie(movieId: movieId)
        } else {
            interactor.unfavoriteMovie(movieId: movieId)
        }
    }
}

extension MovieDetailsPresenter: MovieDetailsPresenterOutputLogic {
    func didRequestMovieDetails(movieDetails: MovieDetailsEntity) {
        let isFavorite = interactor.isMovieFavorite(movieId: movieDetails.id)
        
        let displayModel = MovieDetailsDisplayModel(
            id: movieDetails.id,
            backdropPath: {
                if let backdropPath = movieDetails.backdropPath, !backdropPath.isEmpty {
                    return "\(Constants.TmdbAPI.tmdbImageURL)\(backdropPath)"
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
                    return String(localized: "noOverviewAvailable")
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
                if let revenue = movieDetails.revenue, revenue > 0 {
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
            }(),
            isFavorite: isFavorite
        )
        
        self.displayModel = displayModel
        viewController?.displayContent(displayModel: displayModel)
    }
    
    func didRequestMovieDetailsError() {
        viewController?.displayError()
    }
}
