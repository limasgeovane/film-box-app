protocol ConfigurationRepositoryLogic {
    func fetchConfiguration(completion: @escaping (Result<TMDBImagesConfiguration, Error>) -> Void)
}

struct ConfigurationRepository: ConfigurationRepositoryLogic {
    private let network: NetworkLogic
    
    init(network: NetworkLogic = Network()) {
        self.network = network
    }
    
    func fetchConfiguration(completion: @escaping (Result<TMDBImagesConfiguration, Error>) -> Void) {
        network.request(
            configuration: ConfigurationRequestConfiguration()
        ) { (result: Result<TMDBConfigurationResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.images))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
