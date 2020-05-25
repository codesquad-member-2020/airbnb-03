import Foundation

final class StayViewModel: ViewModelBinding {
    
    typealias Key = Stay
    
    private var stay: Key {
        didSet {
            changedHandler(stay)
        }
    }
    private var changedHandler: Handler
    
    init(with stay: Key, handler changedHandler: @escaping Handler = { _ in }) {
        self.stay = stay
        self.changedHandler = changedHandler
        changedHandler(stay)
    }
    
    func updateCell(_ cell: StayCell) {
        cell.update(with: stay)
    }
    
    func updateNotify(handler changedHandler: @escaping Handler) {
        self.changedHandler = changedHandler
    }
}
