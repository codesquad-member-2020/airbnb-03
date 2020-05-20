import UIKit

class StayListViewController: UIViewController {
    
    private var searchView: SearchTextField!
    private var filterView: SearchFilterView!
    private var stayListCollectionView: StayListCollectionView!
    private var stayListCollectionViewDataSource: StayListCollectionViewDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureLayout()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        stayListCollectionViewDataSource = StayListCollectionViewDataSource()
        stayListCollectionView.dataSource = stayListCollectionViewDataSource
    }
    
    private func configureUI() {
        view.backgroundColor = .white

        searchView = viewFromNib(SearchTextField.self)
        filterView = viewFromNib(SearchFilterView.self)
        stayListCollectionView = StayListCollectionView()
    }

    private func viewFromNib<T>(_ type: T.Type) -> T where T: ViewFromXib {
        guard let view = Bundle.main.loadNibNamed(T.xibName, owner: nil, options: nil)?.first as? T else {
            fatalError("Failed to load from xib: \(T.self)")
        }

        return view
    }
}

// MARK:- Layout
extension StayListViewController {
    private func configureLayout() {
        view.addSubviews(searchView,
                         filterView,
                         stayListCollectionView)
        
        let sidePadding: CGFloat = 24.0
        searchView.constraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                     leadingAnchor: view.leadingAnchor,
                                     bottomAnchor: nil, trailingAnchor: view.trailingAnchor,
                                     padding: .init(top: 16,
                                                    left: sidePadding,
                                                    bottom: 0,
                                                    right: sidePadding),
                                     size: .init(width: 0, height: 48))
        filterView.constraints(topAnchor: searchView.bottomAnchor,
                                     leadingAnchor: searchView.leadingAnchor,
                                     bottomAnchor: nil,
                                     trailingAnchor: searchView.trailingAnchor,
                                     padding: .init(top: 8,
                                                    left: 0,
                                                    bottom: 0,
                                                    right: 0),
                                     size: .init(width: 0, height: 44))
        stayListCollectionView.constraints(topAnchor: filterView.bottomAnchor,
                                         leadingAnchor: searchView.leadingAnchor,
                                         bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                                         trailingAnchor: searchView.trailingAnchor,
                                         padding: .init(top: 12,
                                                        left: 0,
                                                        bottom: 0,
                                                        right: 0))
    }
}
