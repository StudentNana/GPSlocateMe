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
import AVFoundation


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var msg: UILabel!
    var messages: [Message] = [
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.506016, longitude: 13.332060), message: "Bushaltestelle!!!"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.505235, longitude: 13.333229), message: "Sudoku für die Frau"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.504979, longitude: 13.335596), message: "Futter für die Katze"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.504851, longitude: 13.337183), message: "Brief verschicken"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.504947, longitude: 13.338505), message: "Brot kaufen"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.505110, longitude: 13.339754), message: "Kaffee trinken"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.504950, longitude: 13.340956), message: "Blumen für die Frau kaufen"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.503018, longitude: 13.349299), message: "Enten futtern"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.503459, longitude: 13.350481), message: "Pfandflaschen vorbeibringen"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.505434, longitude: 13.352186), message: "Gemüse kaufen"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.507450, longitude: 13.351687), message: "im Park sich ausruhen"),
        Message(coordinate: CLLocationCoordinate2D(latitude: 52.509430, longitude: 13.351313), message: "Kaufe Zeitung")]
    var precision: Double = 0.00001
    var locationManager = CLLocationManager()
    var audioNotification = AVAudioPlayer()
    var color2 = UIColor(netHex:0x00d1ff)
    var color1 = UIColor(netHex: 0xd6ffff)
    
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
        
            let userLocation: CLLocation = locations[0]
            let latitude = userLocation.coordinate.latitude
            let longitude = userLocation.coordinate.longitude
            let latDelta: CLLocationDegrees = 0.005
            let lonDelta: CLLocationDegrees = 0.005
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            self.mapView.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true
            var found: Bool = false
            print(" latitude \(latitude)")
            print(" longitude \(longitude)")
            do {
                audioNotification = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "notification1", ofType: "wav")!))
                audioNotification.prepareToPlay()
            }
            catch {
                print("error")
            }
        
            for message in messages{
                if (abs(message.coordinate.latitude - latitude) <= precision &&
                    abs(message.coordinate.longitude - longitude) <= precision) {
                        print("yes! You are here")
                        msg.text = message.message
                        msg.backgroundColor = color2
                        audioNotification.play()
                        found = true
                        break
                }
            }
            if (!found){
                msg.backgroundColor = color1
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

