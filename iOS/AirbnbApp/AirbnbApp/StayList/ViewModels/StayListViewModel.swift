import UIKit

final class StayListViewModel: NSObject, ViewModelBinding {
    
    typealias Key = StayViewModels
    
    private var stayViewModels: StayViewModels {
        didSet {
            changedHandler(stayViewModels)
        }
    }
    private var changedHandler: Handler
    
    init(with stayList: Key = StayViewModels(), changedHandler: @escaping Handler = { _ in }) {
        self.stayViewModels = stayList
        self.changedHandler = changedHandler
    }
    
    func configure(with stays: [Stay]) {
        self.stayViewModels = StayViewModels(with: stays)
    }
    
    func updateNotify(handler: @escaping Handler) {
        self.changedHandler = handler
    }
}

extension StayListViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stayViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StayCell.reuseIdentifier, for: indexPath) as! StayCell
        let stayViewModel = stayViewModels[indexPath]
        stayViewModel.updateCell(cell)
        #warning("update images with urls")
        return cell
    }
}
