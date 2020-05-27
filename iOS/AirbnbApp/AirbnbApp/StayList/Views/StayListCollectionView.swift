import UIKit

class StayListCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        configureCell()
        configureUI()
    }
    
    private func configureCell() {
        let nib = UINib(nibName: StayCell.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: StayCell.reuseIdentifier)
    }
    
    private func configureUI() {
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
    }
}
