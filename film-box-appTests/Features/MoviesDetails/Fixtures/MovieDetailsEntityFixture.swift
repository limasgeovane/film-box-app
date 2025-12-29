@testable import film_box_app

extension MovieDetailsEntity {
    static func fixture(
        id: Int = 99,
        backdropPath: String? = "/backdrop.jpg",
        originalTitle: String = "Original Title",
        title: String = "Movie Title",
        overview: String? = "Movie overview",
        releaseDate: String = "2025-12-25",
        budget: Int? = 1_000_000,
        revenue: Int? = 5_000_000,
        voteAverage: Double? = 8.5,
        posterPath: String? = "/posterPath.jpg"
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
            voteAverage: voteAverage,
            posterPath: posterPath
        )
    }
}
