import UIKit

final class GuestsFilterSaveButtonView: UIView, ViewFromXib {

    static var xibName: String = String(describing: GuestsFilterSaveButtonView.self)
    static let height: CGFloat = 64.0

    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.layer.cornerRadius = 4.0
        }
    }
    
    override func draw(_ rect: CGRect) {
        drawEdgeLine(edge: .top, lineWidth: 0.3, lineColor: .lightGray)
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        print("hehee")
    }
}
