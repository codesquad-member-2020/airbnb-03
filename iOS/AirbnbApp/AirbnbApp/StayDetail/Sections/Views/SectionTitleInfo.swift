import UIKit

final class SectionTitleInfo: ContentView, ViewFromXib {
    static let xibName = String(describing: SectionTitleInfo.self)

    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
}
