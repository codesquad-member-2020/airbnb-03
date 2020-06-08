import Foundation

class SectionTitleInfoFactory {
    static func makeView(for stayDetail: StayDetail) -> SectionTitleInfo {
        let titleInfo = TitleInfo(for: stayDetail)
        let view = SectionTitleInfo.loadFromXib()

        view.reviewsLabel.updateWith(reviewAverage: titleInfo.reviewAverage, numberOfReviews: titleInfo.numberOfReviews)
        view.addressLabel.text = "\(titleInfo.address)"

        return view
    }
}
