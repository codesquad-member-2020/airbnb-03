import UIKit

class SectionSummary: UIView, ContentView, ViewFromXib {
    static var xibName = String(describing: SectionSummary.self)
    @IBOutlet weak var textView: UITextView!

    func update(with data: String) {
        textView.text = data
    }

    func updateChanges() {
        
    }
}
