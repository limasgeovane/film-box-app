struct TMDBImagesConfiguration: Decodable {
    let secureBaseURL: String
    let posterSizes: [String]
    let backdropSizes: [String]

    enum CodingKeys: String, CodingKey {
        case secureBaseURL = "secure_base_url"
        case posterSizes = "poster_sizes"
        case backdropSizes = "backdrop_sizes"
    }
}
