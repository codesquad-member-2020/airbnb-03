import MapKit

class SectionDetailLocationFactory: SectionDetailViewFactory {
    static func makeView(for stayDetail: StayDetail) -> ContentView {
        let view = SectionDetailLocation.loadFromNib()
        let locationInfo = stayDetail.locationInfo


        view.addressLabel.text = locationInfo.address
        view.descriptionTextView.text = locationInfo.description
        view.transitTextView.text = locationInfo.transit

        return view
    }
}
