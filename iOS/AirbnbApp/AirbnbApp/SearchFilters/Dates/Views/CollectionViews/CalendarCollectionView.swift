import UIKit

final class CalendarCollectionView: UICollectionView {
    
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
        configureHeaderView()
        configureUI()
    }
    
    private func configureCell() {
        let nib = UINib(nibName: DateCell.nibName, bundle: nil)
        register(
            nib,
            forCellWithReuseIdentifier: DateCell.reuseIdentifier)
    }
    
    private func configureHeaderView() {
        let nib = UINib(nibName: CalendarHeaderView.nibName, bundle: nil)
        register(
            nib,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CalendarHeaderView.reuseIdentifier)
    }
    
    private func configureUI() {
        backgroundColor = .white
        showsVerticalScrollIndicator = false
    }
}
