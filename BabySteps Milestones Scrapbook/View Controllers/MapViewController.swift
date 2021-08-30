//
//  MapViewController.swift
//  BabySteps
//
//  Created by Tyler Zwiep on 2021-07-19.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    //outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // properties
    var milestone:Milestone?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
        Setting the map view using MapKit derived from Apple Docs resources,
        available at: https://developer.apple.com/documentation/mapkit
     */
    override func viewWillAppear(_ animated: Bool) {
        if milestone != nil {
            // CLLocationCoordinate2D - part of mapKit
            let location = CLLocationCoordinate2D(latitude: milestone!.lat, longitude: milestone!.long)
        
            // create map pin
            let pin = MKPointAnnotation()
            // set pin to location
            pin.coordinate = location
        
            // add it to map
            mapView.addAnnotation(pin)
        
            // create a map area to display the location
            let mapArea = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
        
            // set the mapView to the zoomed area around the location
            mapView.setRegion(mapArea, animated: false)
        }
    }

}
