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
    }

    private func drawBorder() {
        self.layer.cornerRadius = 20
        self.layer.borderWidth =  1
        self.layer.borderColor = UIColor.black.cgColor
    }
}
