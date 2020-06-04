import UIKit

class SectionBriefInfo: ContentView, ViewFromXib {
    static var xibName: String = .init(describing: SectionBriefInfo.self)

    @IBOutlet weak var hostNameLabel: UILabel!
    @IBOutlet weak var roomInfoLabel: UILabel!
}
