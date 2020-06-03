import UIKit

extension UIView {
    func drawBottomBorder() {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.bounds.height - 0.5, width: self.bounds.width, height: 0.5)
        border.backgroundColor = UIColor.lightGray.cgColor
        self.layer.addSublayer(border)
    }
}
