import Foundation

class StayDetailDataSource: ViewModelBinding {
    typealias Key = StayDetail

    private var stayDetail: StayDetail? {
        didSet {
            if let stayDetail = stayDetail {
                changedHandler(stayDetail)
            }
        }
    }

    private var changedHandler: Handler

    init(with stayDetail: StayDetail? = nil, changedHandler: @escaping Handler = {_ in }) {
        self.stayDetail = stayDetail
        self.changedHandler = changedHandler
    }

    func configure(with stayDetail: StayDetail) {
        self.stayDetail = stayDetail
    }

    func updateNotify(handler: @escaping Handler) {
        self.changedHandler = handler
    }
}
