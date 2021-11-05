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
    
    
    @IBOutlet weak var favoritedImageView: UIImageView!
    @IBOutlet weak var titleSection: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var titleBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel : UILabel!
        
    @IBOutlet weak var cityStateZipLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var telephoneLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    
    var favorited = false
    
    @IBAction func favoriteTapped(_ sender: Any) {
        do {
            try DiskStorage.modify(withKey: "favorite-restaurants", value: self.model)
            updateFavoriteStatusOfCellThatOwnsThis?()
            toggleHeartFilled(fromButtonPress: true)
        } catch {
            print(error)
        }
    }
    
    var updateFavoriteStatusOfCellThatOwnsThis : (() -> ())?
    
    override func viewDidAppear(_ animated: Bool) {
        titleLabel.layer.zPosition = 1
        categoryLabel.layer.zPosition = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            if let restaurants = try DiskStorage.read() {
                guard let model = model else { return }
                for restaurant in restaurants {
                    if restaurant.backgroundImageURL == model.backgroundImageURL {
                        favorited = !favorited
                        updateFavoriteStatusOfCellThatOwnsThis?()
                    }
                }
                
            }
        } catch {
            
        }
        toggleHeartFilled()
        
        configureModel()
    }
    
    private func toggleHeartFilled(fromButtonPress: Bool = false) {
        if fromButtonPress { favorited = !favorited }
        let heartType : UIImage = favorited == true ? UIImage(systemName: "heart.fill")! : UIImage(systemName: "heart")!
        
        favoriteButton.setImage(heartType, for: [])
    }
    
    override func awakeFromNib() {
        self.navigationItem.backBarButtonItem?.title = ""
    }
    override func viewDidLoad() {
        setupLocationServices()
        setupNavBar()
    }
    
    private func setupLocationServices() {
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()

            mapView.delegate = self
        }
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
        } else { categoryLabel.text = "No Category Set" }
        if let title = model?.name {
            titleLabel.text = title
        } else { titleLabel.text = "No Title Set" }
        if let address = model?.location?.address {
            streetLabel.text = address
        } else { streetLabel.text = "No Street Provided" }
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
        } else { telephoneLabel.text = "No telephone number set" }
        if let twitterLabel = model?.contact?.twitter {
            twitterHandleLabel.text =  "@" + twitterLabel
        } else { twitterHandleLabel.text = "No twitter handle set" }
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

