import Foundation

protocol SearchMoviesRepositoryLogic {
    func saveLastMovieSearch(query: String)
}

struct SearchMoviesRepository: SearchMoviesRepositoryLogic {
    private let network: NetworkLogic
    private let lastSearchKey = "LastSearchMoviesQuery"
    
    init(network: NetworkLogic = Network()) {
        self.network = network
    }
    
    func saveLastMovieSearch(query: String) {
        UserDefaults.standard.set(query, forKey: lastSearchKey)
    }
}
