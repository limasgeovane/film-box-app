import UIKit

extension UILabel {
    func setHyphenatedText(_ text: String, language: String = "pt-BR") {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.hyphenationFactor = 1.0
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: self.font as Any,
            .foregroundColor: self.textColor as Any,
            .paragraphStyle: paragraphStyle,
            .languageIdentifier: language
        ]
        
        self.attributedText = NSAttributedString(
            string: text,
            attributes: attributes
        )
    }
}
