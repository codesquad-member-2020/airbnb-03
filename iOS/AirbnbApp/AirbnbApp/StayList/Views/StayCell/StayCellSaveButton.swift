import UIKit

final class StayCellSaveButton: UIButton {
    
    private var buttonImageView: UIImageView!
    
    private enum Image {
        static let savedImage: UIImage? = UIImage(named: "save.fill")
        static let notSavedImage: UIImage? = UIImage(named: "save")
    }
    
    private enum Color {
        static let savedColor: UIColor? = UIColor(named: "save.fill")
        static let notSavedColor: UIColor = UIColor.darkGray
    }
    
    private let imageViewHeight: CGFloat = 18.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func update(with isSaved: Bool) {
        buttonImageView.image = isSaved ? Image.savedImage : Image.notSavedImage
        buttonImageView.tintColor = isSaved ? Color.savedColor : Color.notSavedColor
    }
    
    private func configure() {
        configureImageView()
        configureCornerRadius()
        drawShadow(offset: .zero, color: .darkGray, radius: 2.0, opacity: 0.4)
    }
    
    private func configureImageView() {
        buttonImageView = UIImageView(image: Image.notSavedImage)
        buttonImageView.tintColor = .darkGray
        addSubview(buttonImageView)
        buttonImageView.centerInSuperview()
        buttonImageView.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
        buttonImageView.widthAnchor.constraint(
            equalTo: buttonImageView.heightAnchor,
            multiplier: 1).isActive = true
    }
    
    private func configureCornerRadius() {
        layer.cornerRadius = self.bounds.height / 2
    }
}
