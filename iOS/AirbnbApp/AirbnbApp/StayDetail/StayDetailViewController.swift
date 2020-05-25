import UIKit

class StayDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let detailSectionView = DetailSectionView.loadFromXib()
        view.addSubview(detailSectionView)
    }


    // MARK: - Navigation
}
