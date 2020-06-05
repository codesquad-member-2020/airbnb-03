import MapKit

class SectionDetailMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    var coordinate: CLLocationCoordinate2D!

    override var prefersStatusBarHidden: Bool { true }

    override func viewDidLoad() {
        super.viewDidLoad()

        let annotation = makeAnnotation(coordinate)
        mapView.showAnnotations([annotation], animated: true)
    }

    private func makeAnnotation(_ coordinate: CLLocationCoordinate2D) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)

        return annotation
    }

    @IBAction func closeButtonTouched(_ sender: Any) {
        dismiss(animated: true)
    }
}
