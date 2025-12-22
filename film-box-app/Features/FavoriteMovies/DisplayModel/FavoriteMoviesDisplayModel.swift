struct FavoriteMoviesDisplayModel: Codable {
    let id: Int
    let title: String
    let posterImageName: String?
    let ratingText: String
    let overview: String
}
