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
    
    func idForCell(at indexPath: IndexPath, handler: (Int) -> Void) {
        let stay = stayList[indexPath]
        handler(stay.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StayCell.reuseIdentifier, for: indexPath) as! StayCell
        let stay = stayList[indexPath]
        cell.update(with: stay)
        fetchThumbImages(at: cell, with: stay.images)
        
        return cell
    }
    
    private func fetchThumbImages(at cell: UICollectionViewCell, with imageUrls: [String]) {
        let cell = cell as! StayCell
        imageUrls.enumerated().forEach { (index, imageUrl) in
            NetworkManager.getResource(from: imageUrl) { (result) in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        cell.updateImage(at: index, data: data)
                    }
                case .failure(_):
                    break
                }
            }
        }
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
