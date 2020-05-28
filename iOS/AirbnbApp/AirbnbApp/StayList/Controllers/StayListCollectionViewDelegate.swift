import UIKit

final class StayListCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    
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
