import UIKit

class StayListViewController: UIViewController {
    
    private var searchFieldView: SearchFieldView!
    private var searchFilterView: SearchFilterView!
    private var stayListCollectionView: StayListCollectionView!
    private var stayListCollectionViewDataSource: StayListCollectionViewDataSource!
    private var searchTextFieldDelegate: SearchTextFieldDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureLayout()
        configureCollectionView()
        configureTextFieldDelegate()
    }
    
    private func configureCollectionView() {
        stayListCollectionViewDataSource = StayListCollectionViewDataSource()
        stayListCollectionView.dataSource = stayListCollectionViewDataSource
    }
    
    private func configureUI() {
        view.backgroundColor = .white

        searchFieldView = SearchFieldView.loadFromXib()
        searchFilterView = SearchFilterView.loadFromXib()
        stayListCollectionView = StayListCollectionView()
    }

    private func configureTextFieldDelegate() {
        searchTextFieldDelegate = SearchTextFieldDelegate()
        searchFieldView.configureTextFieldDelegate(searchTextFieldDelegate)
    }

}

// MARK:- Layout
extension StayListViewController {
    private func configureLayout() {
        view.addSubviews(searchFieldView,
                         searchFilterView,
                         stayListCollectionView)
        
        let sidePadding: CGFloat = 24.0
        searchFieldView.constraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                     leadingAnchor: view.leadingAnchor,
                                     bottomAnchor: nil, trailingAnchor: view.trailingAnchor,
                                     padding: .init(top: 16,
                                                    left: sidePadding,
                                                    bottom: 0,
                                                    right: sidePadding),
                                     size: .init(width: 0, height: 48))
        searchFilterView.constraints(topAnchor: searchFieldView.bottomAnchor,
                                     leadingAnchor: searchFieldView.leadingAnchor,
                                     bottomAnchor: nil,
                                     trailingAnchor: searchFieldView.trailingAnchor,
                                     padding: .init(top: 8,
                                                    left: 0,
                                                    bottom: 0,
                                                    right: 0),
                                     size: .init(width: 0, height: 44))
        stayListCollectionView.constraints(topAnchor: searchFilterView.bottomAnchor,
                                         leadingAnchor: searchFieldView.leadingAnchor,
                                         bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                                         trailingAnchor: searchFieldView.trailingAnchor,
                                         padding: .init(top: 12,
                                                        left: 0,
                                                        bottom: 0,
                                                        right: 0))
    }
}
