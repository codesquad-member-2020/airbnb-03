import UIKit

extension UIView {
    func drawShadow(offset: CGSize = .zero,
                    color: UIColor = .darkGray,
                    radius: CGFloat = 1.0,
                    opacity: Float = 0.8,
                    shouldRasterize: Bool = false) {
        self.layer.shadowOffset = offset
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shouldRasterize = shouldRasterize
    }
}
