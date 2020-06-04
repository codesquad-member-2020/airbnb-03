import UIKit

class StayDetailViewController: UIViewController {

    @IBOutlet weak var thumbImagesPagingView: ThumbImagePagingView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var bottomBarView: UIView!

    private var stayDetail: StayDetail!

    override func viewDidLoad() {
        super.viewDidLoad()

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

    private func configureStackView(with stayDetail: StayDetail) {
        addSectionInStackView(title: stayDetail.title, subContentView: SectionTitleInfoFactory.makeView(for: stayDetail))
        addSectionInStackView(title: nil, subContentView: SectionBriefInfoFactory.makeView(for: stayDetail))
        addSectionInStackView(title: "Summary", subContentView: SectionSummaryFactory.makeView(for: stayDetail))
        let amenities = AmenityCollection(items: [
//            Amenity(title: "Internet", symbol: UIImage(systemName: "wifi")),
//            Amenity(title: "TV", symbol: UIImage(systemName: "tv")),
//            Amenity(title: "Wireless Internet", symbol: UIImage(systemName: "bed.double"))
            Amenity(title: "Internet", symbol: nil),
            Amenity(title: "TV", symbol: nil),
            Amenity(title: "Wireless Internet", symbol: nil)
        ])
        addSectionInStackView(title: "Amenities", subContentView: SectionAmenitiesFactory.makeView(for: stayDetail, amenitiesLimit: 5))
//        addSectionInStackView(title: "Amenities", subContentView: SectionAmenitiesFactory.makeView(for: amenities))
    }

    private func addSectionInStackView(title: String?, subContentView: ContentView) {
        let detailSectionView = DetailSectionView.loadFromXib(title: title, contentView: subContentView)
        stackView.addArrangedSubview(detailSectionView)
    }

    private func fetchStayDetail(id: Int) {
        let url = Endpoint.detail(id: id).url
        StayDetailUseCase.getStayDetail(url: url) { result in
            switch result {
            case .success(let stayDetail):
                DispatchQueue.main.async {
                    self.configureStackView(with: stayDetail)
                    print("Hooooola")
                }
            case .failure(let error):
                print("Errorrrrr")
            }
        }
    }
}
