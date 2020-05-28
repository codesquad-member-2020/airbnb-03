import UIKit

class StayDetailViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let detailSectionView = DetailSectionView.loadFromXib()
        stackView.addArrangedSubview(detailSectionView)
    }

    // MARK: - Navigation
}
