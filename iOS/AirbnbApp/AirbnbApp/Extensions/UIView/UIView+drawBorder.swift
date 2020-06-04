import UIKit

extension UIView {
    enum Direction {
        case top, bottom
    }

    func drawBorder(_ direction: Direction, borderWidth: CGFloat = 0.5, borderColor: CGColor = UIColor.lightGray.cgColor) {
        let border = CALayer()
        switch direction {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: borderWidth)
        case .bottom:
            border.frame = CGRect(x: 0, y: self.bounds.height - borderWidth, width: self.bounds.width, height: borderWidth)
        }
        border.backgroundColor = borderColor
        self.layer.addSublayer(border)
    }
}
