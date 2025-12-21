protocol NetworkRequestConfigurator {
    var baseURL: NetworkBaseURL { get }
    var path: String { get }
    var method: NetworkMethod { get }
    var parameters: [String: Any] { get }
    var enconding: NetworkParameterEncoding { get }
    var hearders: [String: String] { get }
}

extension NetworkRequestConfigurator {
    var baseURL: NetworkBaseURL {
        .tmdb
    }
    
    var path: String {
        ""
    }
    
    var method: NetworkMethod {
        .get
    }
    
    var parameters: [String: Any] {
        [:]
    }
    
    var enconding: NetworkParameterEncoding {
        .default
    }
    
    var hearders: [String: String] {
        [:]
    }
}
