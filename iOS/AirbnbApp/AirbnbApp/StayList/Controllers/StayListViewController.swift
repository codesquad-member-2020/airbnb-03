import UIKit

class StayListViewController: UIViewController {
    
    private var searchFieldView: SearchFieldView!
    private var seperatorView: SeperatorView!
    private var searchFilterView: SearchFilterView!
    private var stayListCollectionView: StayListCollectionView!
    private var stayListViewModel: StayListViewModel!
    private var mapButtonView: MapButtonView!
    private var searchTextFieldDelegate: SearchTextFieldDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureLayout()
        configureStayListViewModel()
        configureCollectionView()
        configureTextFieldDelegate()
    }
    
    private func configureStayListViewModel() {
        stayListViewModel = StayListViewModel(changedHandler: { [weak self] (_) in
            self?.stayListCollectionView.reloadData()
        })
    }
    
    private func configureCollectionView() {
        stayListCollectionView.dataSource = stayListViewModel
    }
    
    private func configureUI() {
        view.backgroundColor = .white

        searchFieldView = SearchFieldView.loadFromXib()
        seperatorView = SeperatorView()
        searchFilterView = SearchFilterView.loadFromXib()
        stayListCollectionView = StayListCollectionView()
        mapButtonView = MapButtonView.loadFromXib()
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
                         seperatorView,
                         searchFilterView,
                         stayListCollectionView,
                         mapButtonView
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
        seperatorView.constraints(topAnchor: searchFieldView.bottomAnchor,
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
    }
}
