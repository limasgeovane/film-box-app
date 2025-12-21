struct SearchMoviesRequestConfiguration: NetworkRequestConfigurator {
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
    
    var hearders: [String: String] {
        [
            "Authorization": "Bearer \(NetworkAuthorization.bearerToken)"
        ]
    }
}
