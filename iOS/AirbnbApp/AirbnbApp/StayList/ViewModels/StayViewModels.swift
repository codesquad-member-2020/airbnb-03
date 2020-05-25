import Foundation

final class StayViewModels {
    
    private var stayViewModels: [StayViewModel]
    
    var count: Int {
        stayViewModels.count
    }
    
    init(with stays: [Stay] = []) {
        self.stayViewModels = stays.map { StayViewModel(with: $0) }
    }
    
    subscript(indexPath: IndexPath) -> StayViewModel {
        stayViewModels[indexPath.item]
    }
}
