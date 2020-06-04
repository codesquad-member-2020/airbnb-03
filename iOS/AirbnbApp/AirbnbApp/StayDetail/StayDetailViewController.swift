import UIKit

class StayDetailViewController: UIViewController {

    @IBOutlet weak var thumbImagesPagingView: ThumbImagePagingView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var bottomBarView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        addSectionInStackView(title: "Center of Seattle", subContentView: SectionTitleInfo.loadFromXib())
        addSectionInStackView(title: nil, subContentView: SectionBriefInfo.loadFromXib())
        addSectionInStackView(title: "Summary", subContentView: SectionSummary.loadFromXib())
        addSectionInStackView(title: "Amenities", subContentView: SectionAmenities.loadFromXib())
        
        addSectionInStackView(title: "Summary", subContentView: SectionSummary.loadFromXib())
        addSectionInStackView(title: "Summary", subContentView: SectionSummary.loadFromXib())
        addSectionInStackView(title: "Summary", subContentView: SectionSummary.loadFromXib())

        fetchStayDetail(id: 1)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        topBarView.drawBorder(.bottom)
        bottomBarView.drawBorder(.top)

        let images: [UIImage] = [#imageLiteral(resourceName: "host.super"), #imageLiteral(resourceName: "host.super"), #imageLiteral(resourceName: "host.super")]
        thumbImagesPagingView.configureStackView(numberOfImage: images.count, cornerRadius: 0)
        for (index, image) in images.enumerated() {
            thumbImagesPagingView.updateImage(at: index, image: image)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        stackView.arrangedSubviews.forEach { $0.drawBorder(.top) }
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

    @IBAction func reserveButtonTouched(_ sender: ReserveButton) {
        let viewController = ReservationViewController()
        present(viewController, animated: true, completion: nil)
    }

    // MARK: Private Methods

    private func addSectionInStackView(title: String?, subContentView: UIView) {
        let detailSectionView = DetailSectionView.loadFromXib(titleText: title) { sectionView in
            sectionView.contentView.addSubview(subContentView)
            subContentView.constraints(
                topAnchor: sectionView.contentView.topAnchor,
                leadingAnchor: sectionView.contentView.leadingAnchor,
                bottomAnchor: sectionView.contentView.bottomAnchor,
                trailingAnchor: sectionView.contentView.trailingAnchor
            )
        }
        stackView.addArrangedSubview(detailSectionView)
    }

    private func fetchStayDetail(id: Int) {
        let url = Endpoint.detail(id: id).url
        StayDetailUseCase.getStayDetail(url: url) { result in
            switch result {
            case .success(let stayDetail):
                DispatchQueue.main.async {
                    print("Hooooola")
                }
            case .failure(let error):
                print("Errorrrrr")
            }
        }
    }
}
