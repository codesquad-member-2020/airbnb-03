import UIKit

extension UIView {
    func constraints(topAnchor: NSLayoutYAxisAnchor?, leadingAnchor: NSLayoutXAxisAnchor?, bottomAnchor: NSLayoutYAxisAnchor?, trailingAnchor: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: padding.top).isActive = true
        }
        
        if let leadingAnchor = leadingAnchor {
            self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left).isActive = true
        }
        
        if let bottomAnchor = bottomAnchor {
            self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let trailingAnchor = trailingAnchor {
            self.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor,
                                  constant: padding.top).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor,
                                      constant: padding.left).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor,
                                     constant: -padding.bottom).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor,
                                       constant: -padding.right).isActive = true
    }
    
    func centerInSuperview(constantX: CGFloat = 0, constantY: CGFloat = 0) {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: superview.centerXAnchor,
                                      constant: constantX).isActive = true
        self.centerYAnchor.constraint(equalTo: superview.centerYAnchor,
                                      constant: constantY).isActive = true
    }
}
