import UIKit

protocol StayListCollectionViewTapDelegate: class {
    func didTapCell(at indexPath: IndexPath)
}

final class StayListCollectionView: UICollectionView {
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    weak var tapDelegate: StayListCollectionViewTapDelegate?

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    deinit {
        removeGestureRecognizer(tapGestureRecognizer)
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
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                      action: #selector(didTapCollectionView))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTapCollectionView(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: self)
        guard let indexPath = self.indexPathForItem(at: location) else { return }
        tapDelegate?.didTapCell(at: indexPath)
    }
}
