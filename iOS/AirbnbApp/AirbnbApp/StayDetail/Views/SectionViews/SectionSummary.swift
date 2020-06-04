import UIKit

class SectionSummary: UIView, ContentView, ViewFromXib {

    static var xibName = String(describing: SectionSummary.self)

    @IBOutlet weak var textView: UITextView!

    func updateChanges() {

    }
}

class SectionSummaryFactory {
    static func makeView(for stayDetail: StayDetail) -> SectionSummary {
        let view = SectionSummary.loadFromXib()

        view.textView.text = stayDetail.roomInfo.summary

        return view
    }
}
