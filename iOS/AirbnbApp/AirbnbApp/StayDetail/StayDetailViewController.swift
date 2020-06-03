import UIKit

class StayDetailViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var topBarView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        addToStackView(title: "Center of Seattle", subContentView: SectionTitleInfo.loadFromXib())
        addToStackView(title: nil, subContentView: SectionBriefInfo.loadFromXib())
        addToStackView(title: "Summary", subContentView: SectionSummary.loadFromXib())
        addToStackView(title: "Amenities", subContentView: SectionAmenities.loadFromXib())
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

    // MARK: Private Methods

    private func addToStackView(title: String?, subContentView: UIView) {
        let detailSectionView = DetailSectionView.loadFromXib(titleText: title) { sectionView in
            sectionView.contentView.addSubview(subContentView)
            subContentView.constraints(topAnchor: sectionView.contentView.topAnchor,
                                       leadingAnchor: sectionView.contentView.leadingAnchor,
                                       bottomAnchor: sectionView.contentView.bottomAnchor,
                                       trailingAnchor: sectionView.contentView.trailingAnchor
            )
        }
        stackView.addArrangedSubview(detailSectionView)
    }
}
