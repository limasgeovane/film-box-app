import Foundation

protocol MoviesRepositoryLogic {
    func fetchMovies(query: String, completion: @escaping (Result<MoviesResponseEntity, Error>) -> Void)
    func getLastMovieSearch() -> String?
}


struct MoviesRepository: MoviesRepositoryLogic {
    private let network: NetworkLogic
    
    init(network: NetworkLogic = Network()) {
        self.network = network
    }
    
    func fetchMovies(query: String, completion: @escaping (Result<MoviesResponseEntity, Error>) -> Void) {
        network.request(configuration: MoviesRequestConfiguration(query: query), completion: completion)
    }
    
    func getLastMovieSearch() -> String? {
        UserDefaults.standard.string(forKey: Constants.UserDefaults.lastSearchKey)
    }
}
