struct MovieEntity: Codable {
    let id: Int
    let title: String
    let overview: String?
    let voteAverage: Double?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}
