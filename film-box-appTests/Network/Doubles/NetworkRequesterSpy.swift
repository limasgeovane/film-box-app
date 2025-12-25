import Foundation
@testable import film_box_app

final class NetworkRequesterSpy: NetworkRequester {
    enum Message {
        case request(
            url: String,
            parameters: [String: Any]?,
            headers: [String: String]?
        )
    }

    private(set) var messages: [Message] = []
    var stubbedResult: Result<Data?, Error>?

    func request(
        url: String,
        method: NetworkMethod,
        parameters: [String: Any]?,
        encoding: NetworkParameterEncoding,
        headers: [String: String]?,
        completion: @escaping (Result<Data?, Error>) -> Void
    ) {
        messages.append(.request(url: url, parameters: parameters, headers: headers))

        guard let result = stubbedResult else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        completion(result)
    }
}
