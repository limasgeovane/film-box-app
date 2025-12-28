import Foundation
@testable import film_box_app

extension MovieDetailsDisplayModel {
    static func fixture(
        id: Int = 99,
        backdropPath: String = "https://image.tmdb.org/t/p/w780/backdrop.jpg",
        originalTitle: String = "Original Title",
        title: String = "Movie Title",
        overview: String = "Movie overview",
        releaseDate: String = "December 25th, 2025",
        budget: String = "\(String(localized: "budget")): \(1_000_000.usdFormatter)",
        revenue: String = "\(String(localized: "revenue")): \(5_000_000.usdFormatter)",
        ratingText: String = "\(String(localized: "movieRating")): \(String(format: "%.1f", 8.5))",
        isFavorite: Bool = false
    ) -> Self {
        .init(
            id: id,
            backdropPath: backdropPath,
            originalTitle: originalTitle,
            title: title,
            overview: overview,
            releaseDate: releaseDate,
            budget: budget,
            revenue: revenue,
            ratingText: ratingText,
            isFavorite: isFavorite
        )
    }
}
