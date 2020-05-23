import UIKit

final class StayListViewModel: NSObject, ViewModelBinding {
    
    typealias Key = StayList
    
    private var stayList: StayList = StayList() {
        didSet {
            changedHandler(stayList)
        }
    }
    private var changedHandler: Handler
    
    init(with stayList: Key = StayList(), changedHandler: @escaping Handler = { _ in }) {
        self.stayList = stayList
        self.changedHandler = changedHandler
    }
    
    func configureStayList(_ stayList: [Stay]) {
        self.stayList = StayList(stayList)
    }
    
    func updateNotify(handler: @escaping Handler) {
        self.changedHandler = handler
    }
}

extension StayListViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stayList.numberOfStay
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StayCell.reuseIdentifier, for: indexPath) as! StayCell
        let stay = stayList[indexPath.item]
//        cell.configureViewModel(stayViewModel)
        return cell
    }
}
