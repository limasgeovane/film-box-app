import Foundation

protocol NetworkLogic {
    func request<T: Decodable>(
        configuration: NetworkRequestConfigurator,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

final class Network: NetworkLogic {
    private let networkRequest: NetworkRequester
    private let networkDeserialization: NetworkDeserializable
    
    init(
        networkRequest: NetworkRequester = URLSessionNetworkRequest(),
        networkDeserialization: NetworkDeserializable = NetworkDeserialization()
    ) {
        self.networkRequest = networkRequest
        self.networkDeserialization = networkDeserialization
    }
    
    func request<T: Decodable>(
        configuration: NetworkRequestConfigurator,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        networkRequest.request(
            url: configuration.baseURL.rawValue + configuration.path,
            method: configuration.method,
            parameters: configuration.parameters,
            encoding: configuration.enconding,
            headers: configuration.headers
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                do {
                    let decodedData: T = try self.networkDeserialization.decode(data: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
