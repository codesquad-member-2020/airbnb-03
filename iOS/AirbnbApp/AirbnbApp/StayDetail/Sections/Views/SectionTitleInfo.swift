import UIKit

final class SectionTitleInfo: UIView {
    static let xibName = String(describing: SectionTitleInfo.self)

    @IBOutlet weak var reviewsLabel: ReviewLabel!
    @IBOutlet weak var addressLabel: UILabel!
}

extension SectionTitleInfo: ContentView {
    func needsDelegate() -> Bool {
        return false
    }
}
