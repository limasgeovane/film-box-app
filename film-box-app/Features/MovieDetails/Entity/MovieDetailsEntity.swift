struct MovieDetailsEntity: Decodable {
    let id: Int
    let backdropPath: String?
    let originalTitle: String
    let title: String
    let overview: String?
    let releaseDate: String
    let budget: Int?
    let revenue: Int?
    let voteAverage: Double?
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case title
        case overview
        case releaseDate = "release_date"
        case budget
        case revenue
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}
