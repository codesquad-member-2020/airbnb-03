import Foundation

struct StayList {
    private var stayList: [Stay]
    
    var numberOfStay: Int {
        stayList.count
    }
    
    init(_ stayList: [Stay] = []) {
        self.stayList = stayList
    }
    
    subscript(indexPath: IndexPath) -> Stay {
        stayList[indexPath.item]
    }
}
