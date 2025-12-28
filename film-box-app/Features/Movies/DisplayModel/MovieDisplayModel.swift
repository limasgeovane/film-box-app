struct MovieDisplayModel: Equatable {
    let id: Int
    let posterImagePath: String
    let title: String
    let ratingText: String
    let overview: String
    var isFavorite: Bool
}
