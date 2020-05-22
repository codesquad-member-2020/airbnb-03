import UIKit

class MapButtonView: UIView, ViewFromXib {
    static let xibName = String(describing: MapButtonView.self)

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    private func configure() {
        drawBorder()
        drawShadow()
    }

    private func drawBorder() {
        layer.cornerRadius = 20
        layer.borderWidth =  1
        layer.borderColor = UIColor.black.cgColor
    }

    private func drawShadow() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = .zero
        layer.shadowRadius = 3
        layer.shouldRasterize = true
    }
}
