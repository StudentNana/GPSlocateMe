//
//  ViewController.swift
//  aufgabe7
//
//  Created by Sagitova Gulnaz on 11.12.16.
//  Copyright © 2016 Sagitova Gulnaz. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var msg: UILabel!
    var messages: [Message] = [Message(coordinate: CLLocationCoordinate2D(latitude: 51.45, longitude: 13.54), message: "Kaufe Zeitung")]
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locateMe()
    }
    
    func locateMe() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        //let coordinations = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
        print(" lat \(userLocation.coordinate.latitude)")
        print("long \(userLocation.coordinate.longitude)")
        
        for message in messages{
            if message.coordinate.latitude = 51.45,
        }
    }
    
    class Message{
        var coordinate: CLLocationCoordinate2D
        var message: String
        init(coordinate: CLLocationCoordinate2D, message: String){
            self.coordinate = coordinate
            self.message = message
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

