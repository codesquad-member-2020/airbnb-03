import UIKit

class SectionBriefInfo: ContentView, ViewFromXib {
    static var xibName: String = .init(describing: SectionBriefInfo.self)

    @IBOutlet weak var hostNameLabel: UILabel!
    @IBOutlet weak var roomInfoLabel: UILabel!
}

struct BriefInfo {
    var hostName: String
    var accommodates: Int
    var numberOfBedrooms: Int
    var numberOfBeds: Int
    var numberOfBathrooms: Int
}

extension BriefInfo {
    init(for stayDetail: StayDetail) {
        self.hostName = stayDetail.hostInfo.name
        self.accommodates = stayDetail.roomInfo.accommodates
        self.numberOfBedrooms = stayDetail.roomInfo.bedrooms
        self.numberOfBeds = stayDetail.roomInfo.beds
        self.numberOfBathrooms = stayDetail.roomInfo.bathrooms
    }
}

class SectionBriefInfoFactory {
    static func makeView(for stayDetail: StayDetail) -> SectionBriefInfo {
        let briefInfo = BriefInfo(for: stayDetail)
        let view = SectionBriefInfo.loadFromXib()

        view.hostNameLabel.text = briefInfo.hostName
        let roomInfos: [String] = ["\(briefInfo.accommodates) guests", "\(briefInfo.numberOfBedrooms) bedrooms", "\(briefInfo.numberOfBeds) beds", "\(briefInfo.numberOfBathrooms) baths"]
        view.roomInfoLabel.text = roomInfos.joined(separator: ",")

        return view
    }
}
