import UIKit

extension UIImageView {
    func loadTMDBImage(
        path: String?,
        size: String = "w780",
        placeholder: UIImage? = UIImage(named: "no-image")
    ) {
        image = placeholder

        guard let path, let url = URL(string: "https://image.tmdb.org/t/p/\(size)\(path)") else {
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            let data = try? Data(contentsOf: url)
            let downloadedImage = data.flatMap { UIImage(data: $0) }

            DispatchQueue.main.async {
                self.image = downloadedImage ?? placeholder
            }
        }
    }
}
