import UIKit

class SectionSummary: ContentView, ViewFromXib {

    static var xibName = String(describing: SectionSummary.self)

    @IBOutlet weak var textLabel: UILabel!
}
