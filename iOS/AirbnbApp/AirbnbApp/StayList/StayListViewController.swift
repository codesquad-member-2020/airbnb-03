import UIKit

class StayListViewController: UIViewController {
    
    private var searchViewLayout: UIView!
    private var filterViewLayout: UIView!
    private var collectionViewLayout: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureLayout()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        searchViewLayout = UIView()
        searchViewLayout.backgroundColor = .red
        filterViewLayout = UIView()
        filterViewLayout.backgroundColor = .blue
        collectionViewLayout = UIView()
        collectionViewLayout.backgroundColor = .orange
    }
    
    private func configureLayout() {
        view.addSubview(searchViewLayout)
        view.addSubview(filterViewLayout)
        view.addSubview(collectionViewLayout)
        
        let sidePadding: CGFloat = 24.0
        searchViewLayout.constraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                     leadingAnchor: view.leadingAnchor,
                                     bottomAnchor: nil, trailingAnchor: view.trailingAnchor,
                                     padding: .init(top: 16,
                                                    left: sidePadding,
                                                    bottom: 0,
                                                    right: sidePadding),
                                     size: .init(width: 0, height: 48))
        filterViewLayout.constraints(topAnchor: searchViewLayout.bottomAnchor,
                                     leadingAnchor: searchViewLayout.leadingAnchor,
                                     bottomAnchor: nil,
                                     trailingAnchor: searchViewLayout.trailingAnchor,
                                     padding: .init(top: 8,
                                                    left: 0,
                                                    bottom: 0,
                                                    right: 0),
                                     size: .init(width: 0, height: 44))
        collectionViewLayout.constraints(topAnchor: filterViewLayout.bottomAnchor,
                                         leadingAnchor: searchViewLayout.leadingAnchor,
                                         bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                                         trailingAnchor: searchViewLayout.trailingAnchor,
                                         padding: .init(top: 12,
                                                        left: 0,
                                                        bottom: 0,
                                                        right: 0))
    }
}
