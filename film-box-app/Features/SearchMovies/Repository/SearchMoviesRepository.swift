import Foundation

protocol SearchMoviesRepositoryLogic {
    func saveLastMovieSearch(query: String)
}

struct SearchMoviesRepository: SearchMoviesRepositoryLogic {
    private let network: NetworkLogic
    
    init(network: NetworkLogic = Network()) {
        self.network = network
    }
    
    func saveLastMovieSearch(query: String) {
        UserDefaults.standard.set(query, forKey: Constants.UserDefaults.lastSearchKey)
    }
}
