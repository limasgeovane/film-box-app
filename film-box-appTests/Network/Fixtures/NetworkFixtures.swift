import Foundation
@testable import film_box_app

enum NetworkFixtures {
    struct RequestConfig: NetworkRequestConfigurator {
        let baseURL: NetworkBaseURL = .tmdb
        let path: String = "/movie/550"
        let method: NetworkMethod = .get
        let parameters: [String: Any] = ["language": "en-US"]
        let enconding: NetworkParameterEncoding = .default
        let headers: [String: String] = ["Authorization": "Bearer token"]
    }

    static func makeMovieEntity(
        id: Int = 550,
        title: String = "Fight Club",
        overview: String? = "An insomniac office worker...",
        voteAverage: Double? = 8.4,
        posterPath: String? = "/poster.jpg"
    ) -> MovieEntity {
        MovieEntity(
            id: id,
            title: title,
            overview: overview,
            voteAverage: voteAverage,
            posterPath: posterPath
        )
    }
}
