import UIKit

class SectionBriefInfo: UIView {
    static var xibName: String = .init(describing: SectionBriefInfo.self)

    @IBOutlet weak var hostNameLabel: UILabel!
    @IBOutlet weak var roomInfoLabel: UILabel!
}

extension SectionBriefInfo: ContentView {
    func needsDelegate() -> Bool {
        return false
    }
}
