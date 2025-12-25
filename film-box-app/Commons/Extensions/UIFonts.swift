import UIKit

extension UIFont {
    static let title: UIFont = {
        return UIFont(name: "Roboto-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24, weight: .bold)
    }()
    
    static let primary: UIFont = {
        return UIFont(name: "Roboto-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .medium)
    }()
    
    static let secondaryAppFont: UIFont = {
        return UIFont(name: "Roboto-Light", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .regular)
    }()
    
    static let gridTitle: UIFont = {
        return UIFont(name: "Roboto-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold)
    }()
    
    static let gridRating: UIFont = {
        return UIFont(name: "Roboto-Medium", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .medium)
    }()
    
    static let gridOverview: UIFont = {
        return UIFont(name: "Roboto-Light", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular)
    }()
}
