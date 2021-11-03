//
//  ViewController.swift
//  Restaurant Project
//
//  Created by Yevgeniy Ivanov on 11/2/21.
//

import UIKit
import MapKit
import CoreLocation

protocol ViewControllerDelegate {
    func done(selecteRestaurant:Restaurant)
}
class ViewController: UIViewController {
<<<<<<< HEAD
    
    @IBOutlet weak var tabBar: UITabBar!
    var delegate:ViewControllerDelegate?
    var viewModel = RestaurantViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "icon_map"), style: .done, target: self, action: nil)
        rightBarButton.tintColor = .white
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        title = "Lunch Tyme"
        view.backgroundColor = UIColor(red: 67/255, green: 232/255, blue: 149/255, alpha: 1.0)
    }
    override func viewDidAppear(_ animated: Bool) {
        setupVM()
    }
}
extension ViewController:UICollectionViewDataSource
{
    
    func setupViews(){
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "cell")
    }
    func setupVM(){
        viewModel.updateUI =  { self.collectionView.reloadData() }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.configure(model: viewModel.getRecordAtRow(row: indexPath.row))
        return cell
    }
=======

    var model : Restaurant?
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var titleSection: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidAppear(_ animated: Bool) {
        mapView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        mapView.delegate = self
        locationManager.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
        let leftMargin:CGFloat = 10
                let topMargin:CGFloat = 60
                let mapWidth:CGFloat = view.frame.size.width-20
                let mapHeight:CGFloat = 300
                
                mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        mapView.mapType = MKMapType.standard
               mapView.isZoomEnabled = true
               mapView.isScrollEnabled = true
               
               // Or, if needed, we can position map in the center of the view
               mapView.center = view.center
        titleSection.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
    }


}


extension CGFloat {
    func pixelsToPoints() -> CGFloat {
           return self / UIScreen.main.scale
       }
    
    static func pixelsToPoints(pixels: Int) -> CGFloat {
        return CGFloat(pixels).pixelsToPoints()
    }
}

extension ViewController : MKMapViewDelegate {

}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func getAddress() {
        let geocoder = CLGeocoder()
        //addressTextField.text!
        geocoder.geocodeAddressString("222 NorthEast Drive") { (placemarks, error) in
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
>>>>>>> 83e0aa0382b1214a68106cf152cd723d233b0200
}

extension ViewController: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedRestaurant = viewModel.getRecordAtRow(row: indexPath.row)
        if let selectedRestaurant = selectedRestaurant {
            delegate?.done(selecteRestaurant: selectedRestaurant)
        }
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout
{
    //size of each CollecionViewCell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(collectionView.bounds.size.width), height:180)
    }
}
