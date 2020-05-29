import UIKit

final class DatesFilterSearchButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        configureUI()
    }
    
    private func configureUI() {
        layer.cornerRadius = 8.0
    }
}
