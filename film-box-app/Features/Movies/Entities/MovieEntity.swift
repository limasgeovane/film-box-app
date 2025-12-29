struct MovieEntity: Decodable {
    let id: Int
    let originalTitle: String
    let overview: String?
    let voteAverage: Double?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}
