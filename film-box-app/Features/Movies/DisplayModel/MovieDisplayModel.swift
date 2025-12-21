import Foundation

struct MovieDisplayModel {
    let posterImageName: String
    let title: String
    let ratingText: String
    let overview: String
    
    init(movie: Movies) {
        self.posterImageName = movie.posterImageName
        self.title = movie.originalTitle
        self.ratingText = "\(String(localized: "movieRating")): \(movie.voteAverage)"
        self.overview = movie.overview
    }
}
