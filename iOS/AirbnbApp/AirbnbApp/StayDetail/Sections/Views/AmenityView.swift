import UIKit

class AmenityView: UIView, ViewFromXib {
    static var xibName: String = .init(describing: AmenityView.self)

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var symbolImageView: UIImageView!
}
