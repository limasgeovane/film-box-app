import Foundation

struct FavoriteMoviesDisplayModel {
    let posterImageName: String
    let title: String
    let ratingText: String
    let overview: String
    
    init(favoriteMovies: FavoriteMovies) {
        self.posterImageName = favoriteMovies.posterImageName
        self.title = favoriteMovies.originalTitle
        self.ratingText = "\(String(localized: "movieRating")): \(favoriteMovies.voteAverage)"
        self.overview = favoriteMovies.overview
    }
}
