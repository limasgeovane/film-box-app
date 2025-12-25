import Foundation
@testable import film_box_app

final class NetworkDeserializationSpy: NetworkDeserializable {
    enum Message: Equatable {
        case decode
    }

    private(set) var messages: [Message] = []

    var stubbedDecodedValue: Any?
    var stubbedError: Error?

    func decode<T: Decodable>(data: Data?) throws -> T {
        messages.append(.decode)

        if let error = stubbedError {
            throw error
        }

        return stubbedDecodedValue as! T
    }
}
