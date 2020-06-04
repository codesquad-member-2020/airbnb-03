import UIKit
import MapKit

class SectionMap: ContentView {
    @IBOutlet weak var mapView: MKMapView!

    func update(with annotation: MKPointAnnotation) {
        mapView.delegate = self

        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.isPitchEnabled = false
        mapView.isRotateEnabled = false

        mapView.showAnnotations([annotation], animated: true)
    }
}

extension SectionMap: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView()
        let imageView = UIImageView(image: UIImage(systemName: "house.fill"))
        annotationView.addSubview(imageView)

        return annotationView
    }
}

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
        view.update(with: annotation)

        return view
    }
}
