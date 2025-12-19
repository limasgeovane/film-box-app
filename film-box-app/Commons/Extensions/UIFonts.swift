import UIKit

extension UIFont {
    static let title: UIFont = {
        return UIFont(name: "Roboto-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24, weight: .bold)
    }()
    
    static let primary: UIFont = {
        return UIFont(name: "Roboto-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .medium)
    }()
    
    static let secondary: UIFont = {
        return UIFont(name: "Roboto-Light", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .regular)
    }()
}
