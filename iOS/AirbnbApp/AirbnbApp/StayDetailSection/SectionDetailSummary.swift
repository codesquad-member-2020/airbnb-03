import UIKit

class SectionDetailSummary: UIView {
    @IBOutlet weak var textView: UITextView!
}

extension SectionDetailSummary: ContentView {
    static var xibName: String = .init(describing: SectionDetailSummary.self)

    func needsDelegate() -> Bool {
        false
    }
}
