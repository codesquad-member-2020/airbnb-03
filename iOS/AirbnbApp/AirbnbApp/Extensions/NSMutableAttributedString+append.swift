import UIKit

extension NSMutableAttributedString {
    func append(text: String,
                fontColor: UIColor? = nil,
                fontSize: CGFloat,
                weight: UIFont.Weight = .medium) {
        self.append(NSAttributedString(string: text,
                                       attributes: [
                                        .foregroundColor: fontColor ?? UIColor.black,
                                        .font: UIFont.systemFont(ofSize: fontSize, weight: weight)
        ]))
    }
}
