import UIKit

class SectionDetailSummary: UIView, ContentView {
    static var xibName: String = .init(describing: SectionDetailSummary.self)

    @IBOutlet weak var textView: UITextView!

    func needsDelegate() -> Bool {
        return false
    }
}
