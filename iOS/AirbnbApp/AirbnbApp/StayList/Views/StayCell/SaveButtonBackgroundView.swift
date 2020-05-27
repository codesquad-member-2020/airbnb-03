import UIKit

@IBDesignable
final class SaveButtonBackgroundView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        configureCornerRadius()
        drawShadow()
    }
    
    private func configureCornerRadius() {
        layer.cornerRadius = self.bounds.height / 2
    }
    
    private func drawShadow() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.5
    }
}
