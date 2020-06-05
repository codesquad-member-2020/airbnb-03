import UIKit

class SectionDetailAmenities: UIView {
    @IBOutlet weak var stackView: UIStackView!
}

extension SectionDetailAmenities: ContentView {
    static var xibName: String = .init(describing: SectionDetailAmenities.self)

    func needsDelegate() -> Bool {
        false
    }
}
