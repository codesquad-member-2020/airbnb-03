import UIKit

protocol RoundedBorder: UIView {
    func drawBorder(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: CGColor)
}

extension RoundedBorder {
    func drawBorder(cornerRadius: CGFloat = 5, borderWidth: CGFloat = 1, borderColor: CGColor = UIColor.black.cgColor) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
    }
}
