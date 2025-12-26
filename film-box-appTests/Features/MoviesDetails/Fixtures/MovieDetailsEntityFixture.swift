@testable import film_box_app

struct MovieDetailsEntityFixture {
    static func make(
        backdropPath: String? = "/backdrop.jpg",
        originalTitle: String = "Original Title",
        title: String = "Movie Title",
        overview: String? = "Movie overview",
        releaseDate: String = "2025-12-25",
        budget: Int? = 1000000,
        revenue: Int? = 5000000,
        voteAverage: Double? = 8.5
    ) -> MovieDetailsEntity {
        .init(
            backdropPath: backdropPath,
            originalTitle: originalTitle,
            title: title,
            overview: overview,
            releaseDate: releaseDate,
            budget: budget,
            revenue: revenue,
            voteAverage: voteAverage
        )
    }
}
