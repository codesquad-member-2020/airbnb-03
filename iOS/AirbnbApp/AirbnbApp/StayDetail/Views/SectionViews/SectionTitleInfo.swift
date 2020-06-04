import UIKit

final class SectionTitleInfo: UIView, ContentView, ViewFromXib {
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
        updateWith(titleInfo: titleInfo)
    }

    func updateWith(titleInfo: TitleInfo) {
        reviewsLabel.text = "\(titleInfo.reviewAverage)(\(titleInfo.numberOfReviews))"
        addressLabel.text = "\(titleInfo.address)"
    }

    func updateChanges() {

    }
}

struct TitleInfo {
    let reviewAverage: Float
    let numberOfReviews: Int
    let address: String
}
