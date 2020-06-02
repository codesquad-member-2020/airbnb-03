import UIKit

class StayDetailViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var topBarView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        #warning("테스트용 뷰")
        let detailSectionView = DetailSectionView.loadFromXib(titleText: "Stay with me") { view in
            let subView = SectionSummary.loadFromXib()
            view.contentView.addSubview(subView)
        }
        let detailSectionView2 = DetailSectionView.loadFromXib(titleText: "Stay with me") { view in
            let subView = SectionSummary.loadFromXib()
            view.contentView.addSubview(subView)
        }
        let detailSectionView3 = DetailSectionView.loadFromXib(titleText: "Stay with me") { view in
            let subView = SectionSummary.loadFromXib()
            view.contentView.addSubview(subView)
        }
        let detailSectionView4 = DetailSectionView.loadFromXib(titleText: "Stay with me") { view in
            let subView = SectionSummary.loadFromXib()
            view.contentView.addSubview(subView)
        }
//        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(detailSectionView)
        stackView.addArrangedSubview(detailSectionView2)
        stackView.addArrangedSubview(detailSectionView3)
        stackView.addArrangedSubview(detailSectionView4)

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
