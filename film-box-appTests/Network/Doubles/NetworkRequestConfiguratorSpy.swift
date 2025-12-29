import Foundation
@testable import film_box_app

struct NetworkRequestConfiguratorSpy: Equatable {
    private let baseURL: NetworkBaseURL
    private let path: String
    private let method: NetworkMethod
    private let parameters: [String: Any]
    private let headers: [String: String]
    
    init(from configurator: NetworkRequestConfigurator) {
        self.baseURL = configurator.baseURL
        self.path = configurator.path
        self.method = configurator.method
        self.parameters = configurator.parameters
        self.headers = configurator.headers
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        let sameMethod: Bool = {
            switch (lhs.method, rhs.method) {
            case (.get, .get),
                (.post, .post):
                return true
            default:
                return false
            }
        }()
        
        return lhs.baseURL == rhs.baseURL &&
        lhs.path == rhs.path &&
        sameMethod &&
        NSDictionary(dictionary: lhs.parameters).isEqual(to: rhs.parameters) &&
        lhs.headers == rhs.headers
    }
}
