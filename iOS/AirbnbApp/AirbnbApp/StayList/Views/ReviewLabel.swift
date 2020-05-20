import UIKit

class ReviewLabel: UILabel {
    
    private let leadingImage: UIImage? = UIImage(named: "review.star")
    private let leadingImageTintColor: UIColor! = UIColor(named: "stay.tintcolor")
    private var imageAttachment: NSTextAttachment!
    
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
    
    private func configureImageAttachment() {
        self.imageAttachment = NSTextAttachment()
        let height = self.bounds.height * 0.8
        imageAttachment.bounds = .init(x: 0, y: -(self.bounds.midY - height / 2), width: height, height: height)
        imageAttachment.image = leadingImage?.withTintColor(leadingImageTintColor)
    }
    
    func updateWith(reviewAverage: Double, numberOfReviews: Int) {
        let attributedText = NSMutableAttributedString(attachment: imageAttachment)
        attributedText.append(text: " \(reviewAverage)", fontColor: .black, fontSize: 13, weight: .medium)
        attributedText.append(text: " (\(numberOfReviews))", fontColor: .gray, fontSize: 13, weight: .medium)
        self.attributedText = attributedText
    }
}
