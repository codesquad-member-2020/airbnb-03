import UIKit

final class ThumbImageView: UIImageView {
    
    private let cornerRadius: CGFloat = 12
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        configureUI()
        configureLayer()
    }
    
    private func configureUI() {
        backgroundColor = UIColor(named: "thumb.image.background")
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        clipsToBounds = true
    }
    
    private func configureLayer() {
        layer.cornerRadius = cornerRadius
    }
}
