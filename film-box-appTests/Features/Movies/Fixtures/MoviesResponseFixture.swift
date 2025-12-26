@testable import film_box_app

struct MovieEntityFixture {
    static func makeResponse(
        page: Int = 1,
        results: [MovieEntity] = [makeMovie()],
        totalPages: Int = 10,
        totalResults: Int = 100
    ) -> MoviesResponseEntity {
        .init(
            page: page,
            results: results,
            totalPages: totalPages,
            totalResults: totalResults
        )
    }
    
    static func makeMovie(
        id: Int = 1,
        title: String = "Inception",
        overview: String? = "A mind-bending thriller about dreams within dreams.",
        voteAverage: Double? = 8.8,
        posterPath: String? = "/inceptionPoster.jpg"
    ) -> MovieEntity {
        .init(
            id: id,
            title: title,
            overview: overview,
            voteAverage: voteAverage,
            posterPath: posterPath
        )
    }
}
