import Foundation
@testable import film_box_app

final class NetworkRequesterSpy: NetworkRequester {
    enum Message {
        case request(
            url: String,
            method: NetworkMethod,
            parameters: [String: Any]?,
            headers: [String: String]?
        )
    }

    private(set) var messages: [Message] = []

    var stubbedData: Data?
    var errorToThrow: Error?

    func request(
        url: String,
        method: NetworkMethod,
        parameters: [String: Any]?,
        encoding: NetworkParameterEncoding,
        headers: [String: String]?,
        completion: @escaping (Result<Data?, Error>) -> Void
    ) {
        messages.append(
            .request(
                url: url,
                method: method,
                parameters: parameters,
                headers: headers
            )
        )

        if let errorToThrow {
            completion(.failure(errorToThrow))
            return
        }

        completion(.success(stubbedData))
    }
}
