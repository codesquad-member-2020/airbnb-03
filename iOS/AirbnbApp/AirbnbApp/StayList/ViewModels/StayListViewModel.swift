import UIKit

final class StayListViewModel: NSObject, ViewModelBinding {
    
    typealias Key = [StayViewModel]
    
    private var stayViewModels: [StayViewModel] = [StayViewModel]() {
        didSet {
            changedHandler(stayViewModels)
        }
    }
    private var changedHandler: Handler
    
    init(with stayViewModels: Key = [], changedHandler: @escaping Handler = { _ in }) {
        self.stayViewModels = stayViewModels
        self.changedHandler = changedHandler
    }
    
    func configureStayList(_ stayList: [Stay]) {
        stayViewModels = stayList.map { StayViewModel(with: $0) }
    }
    
    func updateNotify(handler: @escaping ([StayViewModel]) -> Void) {
        self.changedHandler = handler
    }
    
    subscript(indexPath: IndexPath) -> StayViewModel {
        stayViewModels[indexPath.item]
    }
}

extension StayListViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stayViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StayCell.reuseIdentifier, for: indexPath) as! StayCell
        return cell
    }
}
