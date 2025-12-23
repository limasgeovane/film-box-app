struct MoviesRequestConfiguration: NetworkRequestConfigurator {
    private let query: String
    
    init(query: String) {
        self.query = query
    }
    
    var path: String {
        "/search/movie"
    }
    
    var parameters: [String: Any] {
        [
            "query": query
        ]
    }
    
    var headers: [String: String] {
        [
            "Authorization": "Bearer \(NetworkAuthorization.bearerToken)"
        ]
    }
}
