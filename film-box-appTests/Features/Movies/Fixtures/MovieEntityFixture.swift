@testable import film_box_app

extension MovieEntity {
    static func fixture(
        id: Int = 99,
        title: String = "Movie Title",
        overview: String? = "Movie overview",
        voteAverage: Double? = 8.8,
        posterPath: String? = "/inceptionPoster.jpg"
    ) -> Self {
        .init(
            id: id,
            title: title,
            overview: overview,
            voteAverage: voteAverage,
            posterPath: posterPath
        )
    }
}
