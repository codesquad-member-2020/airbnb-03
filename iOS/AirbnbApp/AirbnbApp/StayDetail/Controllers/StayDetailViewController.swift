import UIKit

class StayDetailViewController: UIViewController {

    @IBOutlet weak var thumbImagesPagingView: ThumbImagePagingView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var bottomBarView: BottomBarView!

    var stayDetailID: Int!
    private var stayDetail: StayDetail {
        stayDetailEntity.stayDetail
    }
    private var stayDetailEntity: StayDetailEntity!
    private var stayDetailDataSource: StayDetailDataSource?

    // MARK: - View Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchStayDetail(id: stayDetailID)
        self.stayDetailDataSource = makeStayDetailDataSource()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        topBarView.drawBorder(.bottom)
        bottomBarView.drawBorder(.top)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        stackView.arrangedSubviews.forEach { $0.drawBorder(.top) }
    }

    // MARK: - IBAction

    @IBAction func backButtonTouched(_ sender: UIButton) {
//        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
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

    // MARK: - Configuration

    private func makeStayDetailDataSource() -> StayDetailDataSource {
        StayDetailDataSource() { [weak self] stayDetail in
            self?.bottomBarView.priceLabel.text = "$\(stayDetail.priceInfo.price)"
            self?.bottomBarView.reviewLabel.updateWith(reviewAverage: stayDetail.reviewInfo.average, numberOfReviews: stayDetail.reviewInfo.numberOfReviews)
        }
    }

    private func configureStackView(with stayDetail: StayDetail) {
        addSectionInStackView(title: stayDetail.title, subContentView: SectionTitleInfoFactory.makeView(for: stayDetail))
        addSectionInStackView(title: nil, subContentView: SectionBriefInfoFactory.makeView(for: stayDetail))
        addSectionInStackView(title: "Summary", subContentView: SectionSummaryFactory.makeView(for: stayDetail))
        addSectionInStackView(title: "Amenities", subContentView: SectionAmenitiesFactory.makeView(for: stayDetail, amenitiesLimit: 5))
        addSectionInStackView(title: "Location", subContentView: SectionMapFactory.makeView(for: stayDetail))
    }

    private func addSectionInStackView(title: String?, subContentView: ContentView) {
        let detailSectionView = DetailSectionView.loadFromXib(title: title, contentView: subContentView)
        if subContentView.needsDelegate() {
            subContentView.assignDelegate(self)
        }
        stackView.addArrangedSubview(detailSectionView)
    }

    // MARK: - Fetch Model

    private func fetchStayDetail(id: Int) {
        let url = Endpoint.detail(id: id).url
        StayDetailUseCase.getStayDetail(url: url) { result in
            switch result {
            case .success(let stayDetail):
                DispatchQueue.main.async { [weak self] in
                    self?.stayDetailEntity = StayDetailEntity(stayDetail)
                    self?.stayDetailDataSource?.configure(with: stayDetail)

                    self?.configureStackView(with: stayDetail)
                    self?.thumbImagesPagingView.configureStackView(numberOfImage: stayDetail.images.count, cornerRadius: 0)
                    self?.fetchImages(with: stayDetail.images)
                }
            case .failure(let error):
                print("Errorrrrr")
            }
        }
    }

    private func fetchImages(with imageURLs: [String]) {
        imageURLs.enumerated().forEach { (index, imageURL) in
            StayDetailUseCase.getImage(from: imageURL) { [weak self] result in
                switch result {
                case .success(let image):
                    self?.thumbImagesPagingView.updateImage(at: index, image: image)
                case .failure(let error):
                    debugPrint("Errrrrrr")
                }
            }
        }
    }
}

extension StayDetailViewController: SectionSummaryDelegate {
    func didTapMoreSummaryButton() {
        makeAndPushController(contentTitle: "Summary", viewFactoryType: SectionDetailSummaryFactory.self)
    }

    private func makeAndPushController(contentTitle: String?, viewFactoryType: SectionDetailViewFactory.Type) {
        let viewController = StayDetailSectionViewController()
        viewController.contentTitle = contentTitle
        viewController.viewFactory = viewFactoryType.self
        viewController.stayDetail = stayDetail
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension StayDetailViewController: SectionAmenitiesDelegate {
    func didTapShowAllButton() {
        makeAndPushController(contentTitle: "Amenities", viewFactoryType: SectionDetailAmenitiesFactory.self)

    }
}

extension StayDetailViewController: SectionMapDelegate {
    func didTapMoreLocationButton() {
        makeAndPushController(contentTitle: "Location", viewFactoryType: SectionDetailLocationFactory.self)
    }

    func didTapMapView() {
        let (latitude, longitude) = (stayDetail.locationInfo.latitude, stayDetail.locationInfo.longitude)
        let viewController = SectionDetailMapViewController()
        viewController.coordinate = Coordinate(latitude: latitude, longitude: longitude)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
}
