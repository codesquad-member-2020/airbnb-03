import UIKit

class StayListCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var scrollViewDelegate: ThumbScrollViewDelegate!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StayCell.reuseIdentifier, for: indexPath) as! StayCell
        scrollViewDelegate = ThumbScrollViewDelegate()
        cell.configureScrollViewDelegate(delegate: scrollViewDelegate)
        return cell
    }
}
