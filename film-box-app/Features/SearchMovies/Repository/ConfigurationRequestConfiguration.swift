struct ConfigurationRequestConfiguration: NetworkRequestConfigurator {
    var path: String {
        "/configuration"
    }
    
    var hearders: [String : String] {
        [
            "Authorization": "Bearer \(NetworkAuthorization.bearerToken)"
        ]
    }
}
