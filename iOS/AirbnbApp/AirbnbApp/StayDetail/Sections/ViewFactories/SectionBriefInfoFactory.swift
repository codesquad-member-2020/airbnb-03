import Foundation

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
