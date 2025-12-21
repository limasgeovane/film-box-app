import Foundation

protocol NetworkRequester {
    func request(
        url: String,
        method: NetworkMethod,
        parameters: [String: Any]?,
        encoding: NetworkParameterEncoding,
        headers: [String: String]?,
        completion: @escaping (Result<Data?, Error>) -> Void
    )
}
