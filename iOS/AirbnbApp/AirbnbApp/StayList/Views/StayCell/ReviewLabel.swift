import UIKit

final class ReviewLabel: UILabel, LabelWithLeadingImage {
    
    internal var leadingImage: UIImage? = UIImage(named: "review.star")
    internal var leadingImageTintColor: UIColor! = UIColor(named: "stay.tintcolor")
    internal var imageAttachment: NSTextAttachment!
    var leadingImageYConstant: CGFloat = -1
    
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
    }
    
    func updateWith(reviewAverage: Double, numberOfReviews: Int) {
        let attributedText = NSMutableAttributedString(attachment: imageAttachment)
        attributedText.append(text: " \(reviewAverage)", fontSize: 13, weight: .light)
        attributedText.append(text: " (\(numberOfReviews))", fontColor: .darkGray, fontSize: 13, weight: .light)
        self.attributedText = attributedText
    }
}
