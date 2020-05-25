import UIKit

final class StayListCollectionViewDataSource: NSObject, UICollectionViewDataSource, ViewModelBinding {
    
    typealias Key = StayList
    
    private var stayList: StayList {
        didSet {
            changedHandler(stayList)
        }
    }
    private var changedHandler: Handler
    
    init(with stayList: Key = StayList(), changedHandler: @escaping Handler = { _ in }) {
        self.stayList = stayList
        self.changedHandler = changedHandler
    }
    
    func configure(with stays: [Stay]) {
        self.stayList = StayList(stays)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StayCell.reuseIdentifier, for: indexPath) as! StayCell
        let stay = stayList[indexPath]
        cell.update(with: stay)
        #warning("update images with urls")
        return cell
    }
}

extension StayListCollectionViewDataSource {
    func updateNotify(handler: @escaping Handler) {
        self.changedHandler = handler
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stayList.count
    }
}
