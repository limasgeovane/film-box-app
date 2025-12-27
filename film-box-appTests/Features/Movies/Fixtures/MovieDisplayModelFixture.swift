import Foundation
@testable import film_box_app

extension MovieDisplayModel {
    static func fixture(
        id: Int = 99,
        posterImagePath: String = "\(Constants.TmdbAPI.tmdbImageURL)/posterPath.jpg",
        title: String = "Movie Title",
        ratingText: String = "\(String(localized: "movieRating")): 8.5",
        overview: String = "Movie overview",
        isFavorite: Bool = false
    ) -> Self {
        .init(
            id: id,
            posterImagePath: posterImagePath,
            title: title,
            ratingText: ratingText,
            overview: overview,
            isFavorite: isFavorite
        )
    }
}
