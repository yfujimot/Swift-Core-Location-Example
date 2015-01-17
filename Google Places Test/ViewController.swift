//
//  ViewController.swift
//  Google Places Test
//
//  Created by Yoshio Fujimoto on 1/17/15.
//  Copyright (c) 2015 ThinkFuji. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 47.620506, longitude: -122.349277)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Remember to include corelocation and mapkit frameworks
        
        // Collect current user location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        var gp = GooglePlaces()
        gp.search(location, radius: 2000, query: "coffee") { (items, errorDescription) -> Void in
            
            println("Result count: \(items!.count)")
            for index in 0..<items!.count {
                println([items![index].name])
            }
        }
        
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation: CLLocation = locations[0] as CLLocation
        location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

