import UIKit

func attributed(_ text: String, font: UIFont, lineSpacing: CGFloat = 0) -> NSAttributedString {
    let ps = NSMutableParagraphStyle()
    ps.lineSpacing = lineSpacing
    return NSAttributedString(string: text, attributes: [
        .font: font,
        .paragraphStyle: ps
    ])
}

extension NSAttributedString {
    func height(constrainedTo width: CGFloat) -> CGFloat {
        let rect = self.boundingRect(
            with: CGSize(width: width, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )
        return ceil(rect.height)
    }
}
