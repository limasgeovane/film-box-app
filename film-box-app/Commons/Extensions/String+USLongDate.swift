import Foundation

extension String {
    var usLongDate: String {
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputFormatter.date(from: self) else {
            return self
        }
        
        let calendar = Calendar(identifier: .gregorian)
        let day = calendar.component(.day, from: date)
        
        let daySuffix: String
        switch day {
        case 11, 12, 13:
            daySuffix = "th"
        default:
            switch day % 10 {
            case 1: daySuffix = "st"
            case 2: daySuffix = "nd"
            case 3: daySuffix = "rd"
            default: daySuffix = "th"
            }
        }
        
        let monthYearFormatter = DateFormatter()
        monthYearFormatter.locale = Locale(identifier: "en_US")
        monthYearFormatter.dateFormat = "MMMM yyyy"
        
        let monthYear = monthYearFormatter.string(from: date)
        
        return "\(monthYear.replacingOccurrences(of: " ", with: " \(day)\(daySuffix), "))"
    }
}
