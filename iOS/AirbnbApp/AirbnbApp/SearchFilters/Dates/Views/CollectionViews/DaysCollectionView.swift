import UIKit

final class DaysCollectionView: UICollectionView {
    
    private let spacingForItem: CGFloat = 16.0
    private var dayDates: [StayDate?] = []
    private var firstDayOffset: Int = 0

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
    
    func updateDays(dayDates: [StayDate]) {
        self.dayDates = dayDates
        calculateFirstDayOffset()
        reloadData()
    }
    
    private func calculateFirstDayOffset() {
        let firstDayDate = dayDates.first!
        firstDayOffset = firstDayDate!.date.weekday - 1
        for _ in 0..<firstDayOffset {
            self.dayDates.insert(nil, at: 0)
        }
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
        return dayDates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.reuseIdentifier,
                                                      for: indexPath) as! DayCell
        
        guard let stayDate = dayDates[indexPath.item] else {
            cell.empty()
            return cell
        }
        cell.updateDay(stayDate.date.day)
        return cell
    }
}
