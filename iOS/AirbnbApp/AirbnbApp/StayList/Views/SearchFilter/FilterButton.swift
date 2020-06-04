import UIKit

final class FilterButton: UIButton {
    
    private let sidePadding: CGFloat = 20
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        drawBorder()
    }

    private func drawBorder() {
        layer.cornerRadius = self.bounds.height / 2
        layer.borderWidth =  1
        layer.borderColor = UIColor.lightGray.cgColor
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + (sidePadding * 2), height: size.height)
    }
    
    func update(with filtered: Bool) {
        backgroundColor = filtered ? .darkGray : .white
        setTitleColor(filtered ? .white : .darkGray, for: .normal)
    }
}
