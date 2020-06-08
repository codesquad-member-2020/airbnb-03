import Foundation

class SectionDetailSummaryFactory: SectionDetailViewFactory {
    static func makeView(for stayDetail: StayDetail) -> ContentView {
        let view = SectionDetailSummary.loadFromNib()

        view.textView.text = [stayDetail.roomInfo.summary, stayDetail.roomInfo.space].joined(separator: "\n\n")

        return view
    }
}
