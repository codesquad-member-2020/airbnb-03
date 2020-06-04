import UIKit

final class SectionTitleInfo: ContentView, ViewFromXib {
    static let xibName = String(describing: SectionTitleInfo.self)

    @IBOutlet weak var reviewsLabel: ReviewLabel!
    @IBOutlet weak var addressLabel: UILabel!
}
