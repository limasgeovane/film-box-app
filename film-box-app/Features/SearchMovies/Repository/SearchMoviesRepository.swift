import Foundation

protocol SearchMoviesRepositoryLogic {
    func fetchMovies(query: String, completion: @escaping (Result<SearchMoviesResponseEntity, Error>) -> Void)
    func saveLastMovieSearch(query: String)
    func getLastMovieSearch() -> String?
}


struct SearchMoviesRepository: SearchMoviesRepositoryLogic {
    private let network: NetworkLogic
    private let lastSearchKey = "LastSearchMoviesQuery"
    
    init(network: NetworkLogic = Network()) {
        self.network = network
    }
    
    func fetchMovies(query: String, completion: @escaping (Result<SearchMoviesResponseEntity, Error>) -> Void) {
        network.request(configuration: SearchMoviesRequestConfiguration(query: query), completion: completion)
    }
    
    func saveLastMovieSearch(query: String) {
        UserDefaults.standard.set(query, forKey: lastSearchKey)
    }
    
    func getLastMovieSearch() -> String? {
        UserDefaults.standard.string(forKey: lastSearchKey)
    }
}
