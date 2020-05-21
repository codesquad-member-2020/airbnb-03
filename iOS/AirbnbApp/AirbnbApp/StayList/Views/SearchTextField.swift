import UIKit

class SearchTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
//        drawBorder()
        drawShadow()
    }

    private func drawShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
        layer.shouldRasterize = true
    }

    // FIXME: 텍스트필드의 기본 border와 충돌
    private func drawBorder() {
        layer.masksToBounds = false
        layer.cornerRadius = 12
        layer.borderWidth =  3
        layer.borderColor = UIColor.systemGray.cgColor
    }
}
