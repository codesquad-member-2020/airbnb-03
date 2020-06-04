import UIKit

class SectionSummary: ContentView, ViewFromXib {

    static var xibName = String(describing: SectionSummary.self)

    @IBOutlet weak var textView: UITextView!
}

class SectionSummaryFactory {
    static func makeView(for stayDetail: StayDetail) -> SectionSummary {
        let view = SectionSummary.loadFromXib()

        view.textView.text = stayDetail.roomInfo.summary

        return view
    }
}
