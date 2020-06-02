import UIKit

final class CircleView: UIView {

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
    }
    
    private func configureCornerRadius() {
        layer.cornerRadius = bounds.height / 2
    }
}
