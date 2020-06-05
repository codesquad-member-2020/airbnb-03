import UIKit

class SectionAmenities: UIView {
    static let xibName = String(describing: SectionAmenities.self)

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var showAllButton: DetailButton!
    
    private weak var delegate: SectionAmenitiesDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        stackView.resetArrangedSubViews()
    }

    @IBAction func showAllButtonTouched(_ sender: Any) {
        delegate?.didTapShowAllButton()
    }
}

extension SectionAmenities: ContentView {
    func needsDelegate() -> Bool {
        return true
    }

    func assignDelegate(_ delegate: SectionViewDelegate) {
        self.delegate = delegate as? SectionAmenitiesDelegate
    }
}
