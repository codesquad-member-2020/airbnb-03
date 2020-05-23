import Foundation

class StayViewModel: ViewModelBinding {
    
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
    
    func updateNotify(handler changedHandler: @escaping Handler) {
        self.changedHandler = changedHandler
    }
}
