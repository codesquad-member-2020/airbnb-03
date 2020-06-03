import UIKit

class StayDetailSectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        view = DetailSectionView.loadFromXib()
    }
}
