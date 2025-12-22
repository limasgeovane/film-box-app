struct MovieDetailsRequestConfiguration: NetworkRequestConfigurator {
    private let movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    var path: String {
        "/movie/\(movieId)"
    }
    
    var headers: [String: String] {
        [
            "Authorization": "Bearer \(NetworkAuthorization.bearerToken)"
        ]
    }
}
