@testable import film_box_app

extension MovieEntity {
    static func fixture(
        id: Int = 99,
        originalTitle: String = "Movie Title",
        overview: String? = "Movie overview",
        voteAverage: Double? = 8.5,
        posterPath: String? = "/posterPath.jpg"
    ) -> Self {
        .init(
            id: id,
            originalTitle: originalTitle,
            overview: overview,
            voteAverage: voteAverage,
            posterPath: posterPath
        )
    }
}
