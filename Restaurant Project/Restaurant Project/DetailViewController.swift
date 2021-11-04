//
//  DetailViewController.swift
//  Restaurant Project
//
//  Created by Yevgeniy Ivanov on 11/2/21.
//

import UIKit
import MapKit

import CoreLocation

class DetailViewController: UIViewController {

    var model : Restaurant?
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleSection: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var titleBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel : UILabel!
        
    @IBOutlet weak var cityStateZipLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var telephoneLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    
    @IBAction func favoriteTapped(_ sender: Any) {
        do {
            try DiskStorage.save(withKey: "favorite-restaurants", value: self.model)
        } catch {
            print(error)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        titleLabel.layer.zPosition = 1
        categoryLabel.layer.zPosition = 1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteButton = UIButton.createStandardButton()
        configureModel()
    }
    override func awakeFromNib() {
        self.navigationItem.backBarButtonItem?.title = ""
    }
    override func viewDidLoad() {
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self

            mapView.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            setupNavBar()
        }
        
        //getAddress()
    }
    
    func setupNavBar(){
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1.0),
         NSAttributedString.Key.font: UIFont(name:"Avenir Next Demi Bold",size:17) ?? 0]
          
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "icon_map"), style: .done, target: self, action: nil)
        rightBarButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    
        title = "Lunch Tyme"
        view.backgroundColor = UIColor(red: 67/255, green: 232/255, blue: 149/255, alpha: 1.0)
    }
    func setModel(model: Restaurant) {
        self.model = model
    }
    
    private func configureModel() {
        var cityStateZip = ""
        if let category = model?.category {
            
            categoryLabel.text = category
        }
        if let title = model?.name {
            titleLabel.text = title
        }
        if let address = model?.location?.address {
            streetLabel.text = address
        }
        if let city = model?.location?.city {
            cityStateZip += city + ", "
        }
        if let state = model?.location?.state {
            cityStateZip += state + ", "
        }
        if let zip = model?.location?.postalCode {
            cityStateZip += zip
        }
        cityStateZipLabel.text = cityStateZip
        
        if let telephone = model?.contact?.formattedPhone {
            telephoneLabel.text = telephone
        }
        if let twitterLabel = model?.contact?.twitter {
            twitterHandleLabel.text =  "@" + twitterLabel
        }
    }
    
    private var addressForSearch: String? {
        guard let address = model?.location?.address else {
            return nil
        }
        guard let city = model?.location?.city else {
            return address
        }
        guard let state = model?.location?.state else {
            return "\(address),\(city)"
        }
        return "\(address),\(city),\(state)"
    }

}


extension DetailViewController : MKMapViewDelegate {
    private func getAddress() {
        guard let address = addressForSearch else { return }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            
            guard let placemarks = placemarks, let location = placemarks.first?.location else {
                print("no location found")
                return
            }
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            
            self.mapView.setRegion(region, animated: true)
            //self.mapThis(destinationCord: location.coordinate)
        }
    }
    
    
    
    
    
        private func mapThis(destinationCord: CLLocationCoordinate2D) {

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

extension DetailViewController : CLLocationManagerDelegate {
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


extension UIButton {
    static func createStandardButton() -> UIButton {
        let button = UIButton(type: UIButton.ButtonType.infoLight)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        return button
    }
}
