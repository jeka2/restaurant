//
//  ViewController.swift
//  Restaurant Project
//
//  Created by Yevgeniy Ivanov on 11/2/21.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    var model : Restaurant?
    var okToSearch: Bool? {
        didSet {
            self.getAddress()
        }
    }
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var titleSection: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            mapView.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        //getAddress()
    }
    


}


extension ViewController : MKMapViewDelegate {
    func getAddress() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("222 Northeast drive, fort wayne") { (placemarks, error) in
            
            guard let placemarks = placemarks, let location = placemarks.first?.location else {
                print("no location found")
                return
            }
            self.mapThis(destinationCord: location.coordinate)
        }
    }
    
    
    
    
    
        func mapThis(destinationCord: CLLocationCoordinate2D) {
            
            let sourceCoordinate = locationManager.location?.coordinate // current location
    
            let sourcePlaceMark = MKPlacemark(coordinate: sourceCoordinate!)
            let destinationPlaceMark = MKPlacemark(coordinate: destinationCord)
    
            let sourceItem = MKMapItem(placemark: sourcePlaceMark)
            let destinationItem = MKMapItem(placemark: destinationPlaceMark)
    
            let destinationRequest = MKDirections.Request()
            destinationRequest.source = sourceItem
            destinationRequest.destination = destinationItem
    
            destinationRequest.transportType = .automobile
            destinationRequest.requestsAlternateRoutes = true
    
            let directions = MKDirections(request: destinationRequest)
            
            directions.calculate { (response, error) in
                
                guard let response = response else {
                    
                    if let error = error {
                        print("Cannot calculate direction: \(error)")
                    }
                    return
                }
                
                let route = response.routes[0]
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
            render.strokeColor = .blue
            return render
        }
}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus.rawValue {
            case 4:
                getAddress()
            case 3:
                getAddress()
            default:
                print("blah")
        }
    }
}

