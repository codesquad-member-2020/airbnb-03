import UIKit

extension UIView {
    func animate(
        initialScale: CGFloat = 0.8,
        initialAlpha: CGFloat = 0.5,
        duration: Double) {
        
        self.transform = CGAffineTransform(scaleX: initialScale, y: initialScale)
        self.alpha = initialAlpha
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1.4,
            options: .curveEaseOut,
            animations: {
                self.alpha = 1
                self.transform = .identity
        })
    }
}
