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
    var messages: [Message] = [
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.53856, longitude: 13.3515), message: "Kaufe Zeitung"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.53753, longitude: 13.35972), message: "Sudoku für die Frau"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.538, longitude: 13.35788), message: "Futter für die Katze"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.53844, longitude: 13.35633), message: "Brief verschicken"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.53895, longitude: 13.35392), message: "Brot kaufen"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.53813, longitude: 13.34925), message: "Kaffee trinken"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.53794, longitude: 13.34667), message: "Blumen für die Frau kaufen"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.53815, longitude: 13.34504), message: "Enten futtern"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.5369, longitude: 13.35938), message: "Pfandflaschen vorbeibringen"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.53619, longitude: 13.35792), message: "Gemüse kaufen"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.53468, longitude: 13.35508), message: "im Park sich ausruhen"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.53398, longitude: 13.35367), message: "Bushaltestelle!!!")]
    var precision: Double = 0.00001
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
        var found: Bool = false
        print(" lat \(userLocation.coordinate.latitude)")
        print("long \(userLocation.coordinate.longitude)")
        
        for message in messages{
            if (abs(message.coordinate.latitude - userLocation.coordinate.latitude) <= precision &&
                abs(message.coordinate.longitude - userLocation.coordinate.longitude) <= precision) {
                print("yes! You are here")
                msg.text = message.message
                msg.backgroundColor = UIColor.red
                found = true
                break
            }
        }
        if (!found){
            msg.backgroundColor = UIColor.gray
            msg.text = "Nichts zu erledigen"
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

