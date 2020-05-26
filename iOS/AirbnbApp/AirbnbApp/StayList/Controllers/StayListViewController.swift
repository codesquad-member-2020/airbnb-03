import UIKit

class StayListViewController: UIViewController {
    
    private var searchFieldView: SearchFieldView!
    private var separatorView: SeparatorView!
    private var searchFilterView: SearchFilterView!
    private var stayListCollectionView: StayListCollectionView!
    private var stayListCollectionViewDataSource: StayListCollectionViewDataSource!
    private var stayListCollectionViewDelegate: StayListCollectionViewDelegate!
    private var mapButtonView: MapButtonView!
    private var searchTextFieldDelegate: SearchTextFieldDelegate!
    private var loadingView: LoadingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureLayout()
        configureStayListCollectionViewHandlers()
        configureCollectionView()
        configureTextFieldDelegate()
        fetchFakeStayList()
    }
    
    private func fetchFakeStayList() {
        loadingView.startLoadingAnimation()
        var fakeStays = [Stay]()
        for _ in 0..<19 {
            let randomDouble = (Double(Int.random(in: 0...99)) * 0.01)
            let fakeStay = Stay(id: 1, images: ["https://airbnb-codesquad.s3.ap-northeast-2.amazonaws.com/1.jpg",
            "https://airbnb-codesquad.s3.ap-northeast-2.amazonaws.com/2.jpg",
            "https://airbnb-codesquad.s3.ap-northeast-2.amazonaws.com/3.jpg"], saved: false, reviewAverage: Double(Int.random(in: 2...4)) + randomDouble, numberOfReviews: Int.random(in: 10...999), hostType: "", placeType: "Entire Apartment", city: "Upper East Side", state: "Korea", title: "해운대/펜트하우스/더탑플로어", price: Int.random(in: 100...9999), latitude: "", longitude: "")
            fakeStays.append(fakeStay)
        }
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) {
          (timer) in
            self.stayListCollectionViewDataSource.configure(with: fakeStays)
        }
    }
    
    private func configureStayListCollectionViewHandlers() {
        stayListCollectionViewDataSource = StayListCollectionViewDataSource(changedHandler: { [weak self] (_) in
            DispatchQueue.main.async {
                self?.stayListCollectionView.reloadData()
                self?.dismissLoadingView()
            }
        })

        stayListCollectionViewDelegate = StayListCollectionViewDelegate(handlerWhenSelected: { [weak self] in
            let detailViewController = StayDetailViewController()
            self?.navigationController?.pushViewController(detailViewController, animated: true)
        })
    }
    
    private func dismissLoadingView() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.loadingView.alpha = 0
        }) { (_) in
            self.loadingView.stopLoadingAnimation()
            self.loadingView.isHidden = true
        }
    }
    
    private func configureCollectionView() {
        stayListCollectionView.dataSource = stayListCollectionViewDataSource

        // FIXME: delegate 지정하면 셀 크기가 이상하게 바뀜
        stayListCollectionView.delegate = stayListCollectionViewDelegate
    }
    
    private func configureUI() {
        view.backgroundColor = .white

        searchFieldView = SearchFieldView.loadFromXib()
        separatorView = SeparatorView()
        searchFilterView = SearchFilterView.loadFromXib()
        stayListCollectionView = StayListCollectionView()
        mapButtonView = MapButtonView.loadFromXib()
        loadingView = LoadingView()
    }

    private func configureTextFieldDelegate() {
        searchTextFieldDelegate = SearchTextFieldDelegate()
        searchFieldView.configureTextFieldDelegate(searchTextFieldDelegate)
    }

    // MARK: - IBAction

    @IBAction func mapButtonTouched(_ sender: Any) {
        #warning("동작 확인용 VC")
        let viewController = UIViewController()
        viewController.modalPresentationStyle = .automatic // .fullScreen
        viewController.view.backgroundColor = .systemTeal
        present(viewController, animated: true)
    }
}

// MARK:- Layout
extension StayListViewController {
    private func configureLayout() {
        view.addSubviews(searchFieldView,
                         separatorView,
                         searchFilterView,
                         stayListCollectionView,
                         mapButtonView,
                         loadingView
        )
        
        let sidePadding: CGFloat = 24.0
        searchFieldView.constraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                     leadingAnchor: view.leadingAnchor,
                                     bottomAnchor: nil, trailingAnchor: view.trailingAnchor,
                                     padding: .init(top: 16,
                                                    left: sidePadding + 16,
                                                    bottom: 0,
                                                    right: sidePadding + 16),
                                     size: .init(width: 0,
                                                 height: SearchFieldView.height))
        separatorView.constraints(topAnchor: searchFieldView.bottomAnchor,
                                  leadingAnchor: view.leadingAnchor,
                                  bottomAnchor: nil,
                                  trailingAnchor: view.trailingAnchor,
                                  padding: .init(top: 12,
                                                 left: 0,
                                                 bottom: 0,
                                                 right: 0),
                                  size: .init(width: 0,
                                              height: 0.5))
        searchFilterView.constraints(topAnchor: searchFieldView.bottomAnchor,
                                     leadingAnchor: view.leadingAnchor,
                                     bottomAnchor: nil,
                                     trailingAnchor: view.trailingAnchor,
                                     padding: .init(top: 24,
                                                    left: sidePadding,
                                                    bottom: 0,
                                                    right: sidePadding),
                                     size: .init(width: 0,
                                                 height: SearchFilterView.height))
        stayListCollectionView.constraints(topAnchor: searchFilterView.bottomAnchor,
                                         leadingAnchor: view.leadingAnchor,
                                         bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                                         trailingAnchor: view.trailingAnchor,
                                         padding: .init(top: 12,
                                                        left: sidePadding,
                                                        bottom: 0,
                                                        right: sidePadding))
        mapButtonView.constraints(topAnchor: nil,
                                  leadingAnchor: nil,
                                  bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                                  trailingAnchor: nil,
                                  padding: .init(top: 0,
                                                 left: 0,
                                                 bottom: 20,
                                                 right: 0),
                                  size: CGSize(width: MapButtonView.width,
                                               height: MapButtonView.height))
        mapButtonView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        loadingView.constraints(topAnchor: stayListCollectionView.topAnchor,
                                     leadingAnchor: stayListCollectionView.leadingAnchor,
                                     bottomAnchor: stayListCollectionView.bottomAnchor,
                                     trailingAnchor: stayListCollectionView.trailingAnchor)
    }
}
