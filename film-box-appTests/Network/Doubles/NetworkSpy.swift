import Foundation
@testable import film_box_app

final class NetworkSpy: NetworkLogic {
    enum Message: Equatable {
        case request(NetworkRequestConfiguratorSpy)
    }

    private(set) var messages: [Message] = []

    var stubbedResponse: Any?
    var errorToThrow: Error?

    func request<T: Decodable>(
        configuration: NetworkRequestConfigurator,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        messages.append(.request(NetworkRequestConfiguratorSpy(from: configuration)))

        if let errorToThrow {
            completion(.failure(errorToThrow))
            return
        }

        guard let result = stubbedResponse as? T else {
            completion(.failure(NetworkDeserializationError.decodingFailed))
            return
        }

        completion(.success(result))
    }
}
