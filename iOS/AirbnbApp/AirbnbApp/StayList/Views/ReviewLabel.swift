import UIKit

class ReviewLabel: UILabel, LabelWithLeadingImage {
    
    internal var leadingImage: UIImage? = UIImage(named: "review.star")
    internal var leadingImageTintColor: UIColor! = UIColor(named: "stay.tintcolor")
    internal var imageAttachment: NSTextAttachment!
    
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
        attributedText.append(text: " \(reviewAverage)", fontColor: .black, fontSize: 13, weight: .medium)
        attributedText.append(text: " (\(numberOfReviews))", fontColor: .gray, fontSize: 13, weight: .medium)
        self.attributedText = attributedText
    }
}
