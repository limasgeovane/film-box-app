@testable import film_box_app

extension MovieDetailsDisplayModel {
    static func fixture(
        id: Int = 1,
        backdropPath: String = "\(Constants.TmdbAPI.tmdbImageURL)/backdrop.jpg",
        originalTitle: String = "Original Title",
        title: String = "Movie Title",
        overview: String = "Movie overview",
        releaseDate: String = "25 de dezembro de 2025",
        budget: String = "Budget: $1,000,000",
        revenue: String = "Revenue: $5,000,000",
        ratingText: String = "Rating: 8.5",
        isfavorite: Bool = false
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
            isFavorite: isfavorite
        )
    }
}
