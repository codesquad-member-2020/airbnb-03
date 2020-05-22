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
        configureCollectionViewDelegate()
        configureCell()
        configureUI()
    }
    
    private func configureCollectionViewDelegate() {
        delegate = self
    }
    
    private func configureCell() {
        let nib = UINib(nibName: StayCell.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: StayCell.reuseIdentifier)
    }
    
    private func configureUI() {
        backgroundColor = .clear
    }
}

extension StayListCollectionView: UICollectionViewDelegateFlowLayout {	
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let scrollViewHeight = collectionView.bounds.width * (3 / 5)
        let verticalSpace: CGFloat = 12.0
        let stackViewHeight: CGFloat = 100.0

        return CGSize(width: collectionView.bounds.width, height: scrollViewHeight + verticalSpace + stackViewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        24
    }
}
