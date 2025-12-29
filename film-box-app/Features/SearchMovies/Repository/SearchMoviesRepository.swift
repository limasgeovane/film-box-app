import Foundation

protocol SearchMoviesRepositoryLogic {
    func saveLastMovieSearch(query: String)
}

struct SearchMoviesRepository: SearchMoviesRepositoryLogic {
    func saveLastMovieSearch(query: String) {
        UserDefaults.standard.set(query, forKey: Constants.UserDefaults.lastSearchKey)
    }
}
