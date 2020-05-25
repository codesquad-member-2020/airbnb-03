import Foundation

protocol ViewModelBinding {
    associatedtype Key
    typealias Handler = (Key) -> Void
    
    func updateNotify(handler: @escaping Handler)
}
