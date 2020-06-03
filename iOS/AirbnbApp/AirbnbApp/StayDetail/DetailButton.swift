import UIKit

class DetailButton: UIButton, RoundedBorder {

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
        self.tintColor = .darkText
        self.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
}
