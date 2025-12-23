import UIKit

private let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadTMDBImage(path: String?) {
        let defaultImage = UIImage(named: "no-image")
        image = defaultImage
        
        guard let path, let url = URL(string: path) else { return }
        
        if let cachedImage = imageCache.object(forKey: path as NSString) {
            image = cachedImage
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let data = try? Data(contentsOf: url)
            let downloadedImage = data.flatMap { UIImage(data: $0) }
            
            if let downloadedImage {
                imageCache.setObject(downloadedImage, forKey: path as NSString)
            }
            
            DispatchQueue.main.async {
                self.image = downloadedImage ?? defaultImage
            }
        }
    }
}
