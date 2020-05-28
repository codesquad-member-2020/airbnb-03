import UIKit

final class MapButtonView: UIView, ViewFromXib {
    
    static let xibName = String(describing: MapButtonView.self)
    static let width: CGFloat = 80
    static let height: CGFloat = 40

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
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4
    }
}
