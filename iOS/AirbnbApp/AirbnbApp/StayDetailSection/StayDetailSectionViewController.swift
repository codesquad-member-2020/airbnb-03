import UIKit

class StayDetailSectionViewController: UIViewController {
    @IBOutlet weak var scrollContentView: UIView!

    var contentTitle: String?
    var viewFactory: SectionDetailViewFactory.Type?
    var stayDetail: StayDetail?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureScrollContentView()
    }

    private func configureScrollContentView() {
        guard let factoryType = viewFactory, let stayDetail = stayDetail else { return }

        let sectionContentView = factoryType.makeView(for: stayDetail)
        let sectionView = DetailSectionView.loadFromXib(title: contentTitle, contentView: sectionContentView)

        scrollContentView.addSubview(sectionView)
        sectionView.constraints(
            topAnchor: scrollContentView.topAnchor,
            leadingAnchor: scrollContentView.leadingAnchor,
            bottomAnchor: scrollContentView.bottomAnchor,
            trailingAnchor: scrollContentView.trailingAnchor
        )
    }

    @IBAction func backButtonTouched(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
