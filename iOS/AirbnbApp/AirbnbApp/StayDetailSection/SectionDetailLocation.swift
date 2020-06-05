import UIKit

class SectionDetailLocation: UIView {
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var transitTextView: UITextView!
}

extension SectionDetailLocation: ContentView {
    static var xibName: String = .init(describing: SectionDetailLocation.self)

    func needsDelegate() -> Bool {
        false
    }
}
