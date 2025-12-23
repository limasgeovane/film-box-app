struct MovieEntity: Decodable {
    let id: Int
    let title: String
    let overview: String?
    let voteAverage: Double?
    let posterPath: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
