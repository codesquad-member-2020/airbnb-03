import UIKit
import MapKit

class SectionMap: ContentView, RoundedBorder {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        drawBorders(cornerRadius: 12, borderWidth: 0.1, borderColor: UIColor.white.cgColor)
        clipsToBounds = true
    }

    func updateMap(with annotation: MKPointAnnotation) {
//        mapView.delegate = self

        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.isPitchEnabled = false
        mapView.isRotateEnabled = false

        mapView.showAnnotations([annotation], animated: true)
    }
}

//extension SectionMap: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let annotationView = MKAnnotationView()
//        let imageView = UIImageView(image: UIImage(systemName: "house.fill"))
//        annotationView.addSubview(imageView)
//
//        return annotationView
//    }
//}

struct MapInfo {
    let address: String
    let description: String
    let latitude: Double
    let longitude: Double
}

extension MapInfo {
    init(for stayDetail: StayDetail) {
        self.address = stayDetail.locationInfo.address
        self.description = stayDetail.locationInfo.description
        self.latitude = stayDetail.locationInfo.latitude
        self.longitude = stayDetail.locationInfo.longitude
    }
}

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
