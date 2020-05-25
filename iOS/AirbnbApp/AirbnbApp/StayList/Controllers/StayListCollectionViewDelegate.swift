import UIKit

class StayListCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    var handlerWhenSelected: () -> Void

    init(handlerWhenSelected: @escaping () -> Void = {}) {
        self.handlerWhenSelected = handlerWhenSelected
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handlerWhenSelected()
    }
}
