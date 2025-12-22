import Foundation

struct MovieDetails: Decodable {
    let backdropPath: String
    let originalTitle: String
    let title: String
    let overview: String
    let releaseDate: String
    let budget: Int?
    let revenue: Int?
    let voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case title
        case overview
        case releaseDate = "release_date"
        case budget
        case revenue
        case voteAverage = "vote_average"
    }
}
