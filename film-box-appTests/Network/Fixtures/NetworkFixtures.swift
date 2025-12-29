@testable import film_box_app

enum NetworkFixtures {
    struct Response: Codable, Equatable {
        let name: String
        let id: Int
    }
    
    static func makeResponse(
        name: String = "Test Movie",
        id: Int = 99
    ) -> Response {
        Response(name: name, id: id)
    }
    
    struct RequestConfig: NetworkRequestConfigurator {
        var baseURL: NetworkBaseURL = .tmdb
        var path: String = "/test"
        var method: NetworkMethod = .get
        var parameters: [String: Any] = ["key": "value"]
        var enconding: NetworkParameterEncoding = .default
        var headers: [String: String] = ["Header": "Value"]
    }
}
