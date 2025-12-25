import Foundation

enum Constants {
    enum UserDefaults {
        static let lastSearchKey = "LastSearchMoviesQuery"
        static let favoritesMoviesKey = "FavoriteMovies"
    }
    
    enum TmdbAPI {
        static let tmdbImageURL = "https://image.tmdb.org/t/p/w780"
        
        static let language: String = {
            let locale = Locale.current
            if #available(iOS 16.0, *) {
                let lang = locale.language.languageCode?.identifier ?? "en"
                let region = locale.region?.identifier ?? "US"
                return "\(lang)-\(region)"
            } else {
                let lang = locale.languageCode ?? "en"
                let region = locale.regionCode ?? "US"
                return "\(lang)-\(region)"
            }
        }()
    }
}
