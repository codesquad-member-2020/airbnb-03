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
        backgroundColor = .yellow
    }
}

extension StayListCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width, height: collectionView.bounds.height / 2)
    }
}
