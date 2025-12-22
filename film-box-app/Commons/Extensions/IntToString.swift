import Foundation

extension Int {
    var usdformatter: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.locale = Locale(identifier: "en_US")

        return formatter.string(from: NSNumber(value: self)) ?? "$0"
    }
}
