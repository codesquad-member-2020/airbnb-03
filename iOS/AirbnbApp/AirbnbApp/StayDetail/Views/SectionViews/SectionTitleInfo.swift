import UIKit

final class SectionTitleInfo: UIView, ContentView, ViewFromXib {
    static let xibName = String(describing: SectionTitleInfo.self)

    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    func updateChanges() {

    }
}

struct TitleInfo {
    let reviewAverage: Float
    let numberOfReviews: Int
    let address: String
}

extension TitleInfo {
    init(for stayDetail: StayDetail) {
        self.reviewAverage = stayDetail.reviewInfo.average
        self.numberOfReviews = stayDetail.reviewInfo.numberOfReviews
        self.address = stayDetail.locationInfo.address
    }
}

class SectionTitleInfoFactory {
    static func makeView(for stayDetail: StayDetail) -> SectionTitleInfo {
        let titleInfo = TitleInfo(for: stayDetail)
        let view = SectionTitleInfo.loadFromXib()

        view.reviewsLabel.text = "\(titleInfo.reviewAverage)(\(titleInfo.numberOfReviews))"
        view.addressLabel.text = "\(titleInfo.address)"

        return view
    }
}
