import Foundation

struct StayList {
    private var stayList: [Stay]
    
    var count: Int {
        stayList.count
    }
    
    init(_ stayList: [Stay] = []) {
        self.stayList = stayList
    }
    
    subscript(index: Int) -> Stay {
        stayList[index]
    }
    
    subscript(indexPath: IndexPath) -> Stay {
        stayList[indexPath.item]
    }

    mutating func updateSaved(at indexPath: IndexPath, saved: Bool) {
        stayList[indexPath.item].saved = saved
    }
}
