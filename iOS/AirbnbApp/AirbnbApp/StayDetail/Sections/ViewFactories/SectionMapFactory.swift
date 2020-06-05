import MapKit

class SectionMapFactory {
    static func makeView(for stayDetail: StayDetail) -> SectionMap {
        let mapInfo = MapInfo(for: stayDetail)
        let view = SectionMap.loadFromNib()

        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: mapInfo.latitude, longitude: mapInfo.longitude)
        view.updateMap(with: annotation)

        view.addressLabel.text = mapInfo.address
        view.descriptionLabel.text = mapInfo.description

        return view
    }
}
