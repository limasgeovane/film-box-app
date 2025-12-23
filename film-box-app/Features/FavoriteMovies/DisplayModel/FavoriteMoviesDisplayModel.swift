struct FavoriteMoviesDisplayModel: Codable, Equatable {
    let id: Int
    let title: String
    let posterImageName: String?
    let ratingText: String
    let overview: String
}
