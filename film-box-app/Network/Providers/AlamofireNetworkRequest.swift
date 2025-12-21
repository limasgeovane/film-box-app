import Alamofire
import Foundation

struct AlamofireNetworkRequest: NetworkRequester {
    func request(
        url: String,
        method: NetworkMethod,
        parameters: [String: Any]?,
        encoding: NetworkParameterEncoding,
        headers: [String: String]?,
        completion: @escaping (Result<Data?, Error>) -> Void
    ) {
        AF.request(
            url,
            method: toHTTPMethod(method: method),
            parameters: parameters,
            encoding: toParameterEnconding(encoding: encoding),
            headers: toHTTPHeaders(headers: headers)
        )
        .validate()
        .response { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func toHTTPMethod(method: NetworkMethod) -> HTTPMethod {
        switch method {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
    
    private func toHTTPHeaders(headers: [String: String]?) -> HTTPHeaders? {
        guard let headers else {
            return nil
        }
        
        var httpHeaders = HTTPHeaders()
        
        headers.forEach { (key: String, value: String) in
            httpHeaders.add(name: key, value: value)
        }
        
        return httpHeaders
    }
    
    private func toParameterEnconding(encoding: NetworkParameterEncoding) -> ParameterEncoding {
        switch encoding {
        case .default:
            return URLEncoding.default
        case .httpBody:
            return URLEncoding.default
        }
    }
}
