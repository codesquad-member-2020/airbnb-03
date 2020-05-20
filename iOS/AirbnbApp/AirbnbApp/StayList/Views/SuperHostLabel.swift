import UIKit

class SuperHostLabel: UILabel, LabelWithLeadingImage {
    
    internal var leadingImage: UIImage? = UIImage(named: "host.super")
    internal var leadingImageTintColor: UIColor! = UIColor(named: "stay.tintcolor")
    internal var imageAttachment: NSTextAttachment!
    internal var leadingImageYConstant: CGFloat = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        configureImageAttachment()
        configureLabel()
    }
    
    private func configureLabel() {
        let attributedText = NSMutableAttributedString(attachment: imageAttachment)
        attributedText.append(text: " Superhost", fontColor: .black, fontSize: 13, weight: .medium)
        self.attributedText = attributedText
    }
}
