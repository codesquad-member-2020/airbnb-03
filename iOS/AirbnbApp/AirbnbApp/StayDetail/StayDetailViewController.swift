import UIKit

class StayDetailViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var topBarView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        #warning("테스트용 뷰")
        let detailSectionView = DetailSectionView.loadFromXib(titleText: "Stay with me") { view in
//            view.addSubContentViews()
        }
        stackView.addArrangedSubview(detailSectionView)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        topBarView.drawBottomBorder()
    }

    // MARK: - IBAction

    @IBAction func backButtonTouched(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func detailTouched(_ sender: Any) {
        print("detail button")
        let viewController = StayDetailSectionViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
