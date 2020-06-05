import UIKit

class StayDetailSectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func backButtonTouched(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
