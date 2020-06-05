import Foundation

class SectionSummaryFactory {
    static func makeView(for stayDetail: StayDetail) -> SectionSummary {
        let view = SectionSummary.loadFromXib()

        view.textLabel.text = stayDetail.roomInfo.summary

        return view
    }
}
