import UIKit

final class DaysCollectionView: UICollectionView {
    
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
        dataSource = self
    }
    
    private func configureUI() {
        backgroundColor = .white
    }
}

extension DaysCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 7.0
        return CGSize(width: width, height: width)
    }
}

extension DaysCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int.random(in: 28...42)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.reuseIdentifier,
                                                      for: indexPath) as! DayCell
        cell.backgroundColor = UIColor(red: CGFloat.random(in: 0.3...1.0),
                                       green: CGFloat.random(in: 0.3...1.0),
                                       blue: CGFloat.random(in: 0.3...1.0),
                                       alpha: CGFloat.random(in: 0.5...1.0))
        return cell
    }
}
