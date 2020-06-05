import UIKit

class SectionSummary: UIView {

    static var xibName = String(describing: SectionSummary.self)

    @IBOutlet weak var textLabel: UILabel!

    private weak var delegate: SectionSummaryDelegate?

    @IBAction func moreButtonTouched(_ sender: Any) {
        delegate?.didTapMoreSummaryButton()
    }
}

extension SectionSummary: ContentView {
    func needsDelegate() -> Bool {
        return true
    }

    func assignDelegate(_ delegate: SectionViewDelegate) {
        self.delegate = delegate as? SectionSummaryDelegate
    }
}
