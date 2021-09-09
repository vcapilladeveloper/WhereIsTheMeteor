//
//  MapViewController.swift
//  WhereIsTheMeteor
//
//  Created by Victor Capilla Developer on 9/9/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var coordinates: CLLocation!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addAnnotation()
    }
    
    func addAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates.convertToLocationCoordinate()
        mapView.addAnnotation(annotation)
        mapView.centerToLocation(coordinates)
    }
    
}

extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    var coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    coordinateRegion.span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
    setRegion(coordinateRegion, animated: true)
  }
}

extension CLLocationCoordinate2D {
    func convertToLocation() -> CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
}

extension CLLocation {
    func convertToLocationCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
    }
}
