import Foundation

class StayViewModel: ViewModelBinding {
    
    typealias Key = Stay?
    
    private var stay: Key {
        didSet {
            changedHandler(stay)
        }
    }
    private var changedHandler: Handler
    
    init(with stay: Key = nil, handler changedHandler: @escaping Handler = { _ in }) {
        self.stay = stay
        self.changedHandler = changedHandler
    }
    
    func updateNotify(handler changedHandler: @escaping (Stay?) -> Void) {
        self.changedHandler = changedHandler
    }
}
