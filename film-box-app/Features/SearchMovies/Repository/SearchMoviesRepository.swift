import Foundation

protocol SearchMoviesRepositoryLogic {
    func fetchMovies(query: String, completion: @escaping (Result<SearchMoviesResponse, Error>) -> Void)
}

struct SearchMoviesRepository: SearchMoviesRepositoryLogic {
    private let network: NetworkLogic
    
    init(network: NetworkLogic = Network()) {
        self.network = network
    }
    
    func fetchMovies(query: String, completion: @escaping (Result<SearchMoviesResponse, Error>) -> Void) {
        network.request(configuration: SearchMoviesRequestConfiguration(query: query), completion: completion)
    }
}
