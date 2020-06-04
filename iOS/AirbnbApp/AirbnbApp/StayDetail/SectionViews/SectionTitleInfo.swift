import UIKit

final class SectionTitleInfo: UIView, ViewFromXib {
    static let xibName = String(describing: SectionTitleInfo.self)

    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    var titleInfo: TitleInfo? = nil {
        didSet { configure() }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    private func configure() {
        guard let titleInfo = titleInfo else { return }

        reviewsLabel.text = "\(titleInfo.reviewAverage)(\(titleInfo.numberOfReviews))"
        addressLabel.text = "\(titleInfo.address)"
    }
}

struct TitleInfo {
    let reviewAverage: Float
    let numberOfReviews: Int
    let address: String
}
