import UIKit

class SeperatorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure(color: UIColor? = .lightGray, alpha: CGFloat = 0.7) {
        backgroundColor = color
        self.alpha = alpha
    }
}
