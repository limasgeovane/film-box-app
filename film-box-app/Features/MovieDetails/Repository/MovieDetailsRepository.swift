protocol MovieDetailsRepositoryLogic {
    func fetchMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetailsEntity, Error>) -> Void)
}

struct MovieDetailsRepository: MovieDetailsRepositoryLogic {
    private let network: NetworkLogic
    
    init(network: NetworkLogic = Network()) {
        self.network = network
    }
    
    func fetchMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetailsEntity, Error>) -> Void) {
        network.request(configuration: MovieDetailsRequestConfiguration(movieId: movieId), completion: completion)
    }
}
