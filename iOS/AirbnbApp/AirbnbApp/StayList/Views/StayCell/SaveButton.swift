import UIKit

final class SaveButton: UIButton {
    
    private var buttonImageView: UIImageView!
    
    private let savedImage: UIImage? = UIImage(named: "save.fill")
    private let notSavedImage: UIImage? = UIImage(named: "save")
    private let savedColor: UIColor? = UIColor(named: "save.fill")
    private let notSavedColor: UIColor = UIColor.darkGray
    private let imageViewHeight: CGFloat = 18.0
    private var saved: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func updateImage(with saved: Bool) {
        if saved {
            buttonImageView.image = savedImage
            buttonImageView.tintColor = savedColor
        } else {
            buttonImageView.image = notSavedImage
            buttonImageView.tintColor = notSavedColor
        }
    }
    
    private func configure() {
        configureImageView()
        configureCornerRadius()
        drawShadow()
    }
    
    private func configureImageView() {
        buttonImageView = UIImageView(image: notSavedImage)
        buttonImageView.tintColor = .darkGray
        addSubview(buttonImageView)
        buttonImageView.centerInSuperview()
        buttonImageView.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
        buttonImageView.widthAnchor.constraint(equalTo: buttonImageView.heightAnchor,
                                         multiplier: 1).isActive = true
    }
    
    private func configureCornerRadius() {
        layer.cornerRadius = self.bounds.height / 2
    }
    
    private func drawShadow() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.4
    }
}
