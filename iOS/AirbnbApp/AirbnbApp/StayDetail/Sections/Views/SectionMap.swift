import UIKit
import MapKit

class SectionMap: ContentView, RoundedBorder {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        configure()
    }

    func updateMap(with annotation: MKPointAnnotation) {
//        mapView.delegate = self

        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.isPitchEnabled = false
        mapView.isRotateEnabled = false

        mapView.showAnnotations([annotation], animated: true)
    }

    private func configure() {
        drawBorders(cornerRadius: 12, borderWidth: 0.1, borderColor: UIColor.white.cgColor)
        clipsToBounds = true
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
