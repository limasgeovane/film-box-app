import Foundation

struct URLSessionNetworkRequest: NetworkRequester {
    func request(
        url: String,
        method: NetworkMethod,
        parameters: [String: Any]?,
        encoding: NetworkParameterEncoding,
        headers: [String: String]?,
        completion: @escaping (Result<Data?, Error>) -> Void
    ) {
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = toHTTPMethod(method: method)
        request.allHTTPHeaderFields = headers
        
        if let parameters = parameters {
            switch encoding {
            case .default:
                if method == .get {
                    if var components = URLComponents(string: url.absoluteString) {
                        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                        request.url = components.url
                    }
                } else {
                    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                    let queryString = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
                    request.httpBody = queryString.data(using: .utf8)
                }
            case .httpBody:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    completion(.failure(error))
                    return
                }
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                completion(.success(data))
            }
        }
    
        task.resume()
    }
    
    private func toHTTPMethod(method: NetworkMethod) -> String {
        switch method {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}

enum NetworkError: Error {
    case invalidURL
}

