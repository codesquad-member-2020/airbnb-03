import UIKit

final class DaysCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        collectionViewLayout = UICollectionViewFlowLayout()
        configureCell()
        configureUI()
        configureCollectionView()
    }
    
    private func configureCell() {
        let nib = UINib(nibName: DayCell.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: DayCell.reuseIdentifier)
    }
    
    private func configureCollectionView() {
        delegate = self
    }
    
    private func configureUI() {
        backgroundColor = .white
    }
}

extension DaysCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 7.0
        return CGSize(width: width, height: width)
    }
}
