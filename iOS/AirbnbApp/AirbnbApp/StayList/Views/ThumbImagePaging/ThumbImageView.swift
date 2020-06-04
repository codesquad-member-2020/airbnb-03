import UIKit

final class ThumbImageView: UIImageView {
    
    private var cornerRadius: CGFloat = 12
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    init(frame: CGRect = .zero, cornerRadius: CGFloat) {
        super.init(frame: frame)
        self.cornerRadius = cornerRadius
        configure()
    }
    
    private func configure() {
        configureUI()
        configureLayer()
    }
    
    private func configureUI() {
        backgroundColor = UIColor(named: "thumb.image.background")
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
        clipsToBounds = true
    }
    
    private func configureLayer() {
        layer.cornerRadius = cornerRadius
    }
}
