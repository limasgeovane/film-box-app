import Foundation

final class ImageURLBuilder {
    private let configuration: TMDBImagesConfiguration
    
    init(configuration: TMDBImagesConfiguration) {
        self.configuration = configuration
    }
    
    func posterURL(path: String?) -> URL? {
        guard let path else { return nil }
        
        let size = configuration.posterSizes.contains("w342") ? "w342" : configuration.posterSizes.first ?? "original"
        
        return URL(
            string: "\(configuration.secureBaseURL)\(size)\(path)"
        )
    }
}
