import UIKit

final class MonthsCollectionView: UICollectionView {
    
    private let spacingForItem: CGFloat = 16.0

    override init(frame: CGRect,
                  collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame,
                   collectionViewLayout: UICollectionViewFlowLayout())
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        configureCell()
        configureUI()
        configureCollectionView()
    }
    
    private func configureCell() {
        let nib = UINib(nibName: MonthCell.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: MonthCell.reuseIdentifier)
    }
    
    private func configureCollectionView() {
        delegate = self
        dataSource = self
    }
    
    private func configureUI() {
        backgroundColor = .white
    }
}

extension MonthsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        #warning("dynamic cell size")
        return .init(width: collectionView.bounds.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacingForItem
    }
}

extension MonthsCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCell.reuseIdentifier,
                                                      for: indexPath) as! MonthCell
        return cell
    }
}
