import UIKit

class StayDetailViewController: UIViewController {

    @IBOutlet weak var thumbImagesPagingView: ThumbImagePagingView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var bottomBarView: UIView!

    var stayDetailID: Int!
    private var stayDetail: StayDetail!

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchStayDetail(id: stayDetailID)
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

    // MARK: Private Methods

    private func configureStackView(with stayDetail: StayDetail) {
        addSectionInStackView(title: stayDetail.title, subContentView: SectionTitleInfoFactory.makeView(for: stayDetail))
        addSectionInStackView(title: nil, subContentView: SectionBriefInfoFactory.makeView(for: stayDetail))
        addSectionInStackView(title: "Summary", subContentView: SectionSummaryFactory.makeView(for: stayDetail))
        addSectionInStackView(title: "Amenities", subContentView: SectionAmenitiesFactory.makeView(for: stayDetail, amenitiesLimit: 5))
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
                    self.thumbImagesPagingView.configureStackView(numberOfImage: stayDetail.images.count, cornerRadius: 0)
                    self.fetchImages(with: stayDetail.images)
                }
            case .failure(let error):
                print("Errorrrrr")
            }
        }
    }

    private func fetchImages(with imageURLs: [String]) {
        imageURLs.enumerated().forEach { (index, imageURL) in
            StayDetailUseCase.getImage(from: imageURL) { result in
                switch result {
                case .success(let image):
                    self.thumbImagesPagingView.updateImage(at: index, image: image)
                case .failure(let error):
                    debugPrint("Errrrrrr")
                }
            }
        }

    }
}
