//
//  ViewController.swift
//  Google Places Test
//
//  Created by Yoshio Fujimoto on 1/17/15.
//  Copyright (c) 2015 ThinkFuji. All rights reserved.
//

import UIKit
import CoreLocation

var placesOfInterest: [String] = []

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    let locationManager = CLLocationManager()
    var location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 38.9380912, longitude: -77.0449327)
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        tableview.reloadData()
    }
    
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
        gp.search(location, radius: 20000, query: "food") { (items, errorDescription) -> Void in // Radius in meters
            
            println("Result count: \(items!.count)")
            
            for index in 0..<items!.count {
                
                placesOfInterest.append(items![index].name)
                println(placesOfInterest)
            }
            
            self.tableview.reloadData()
        }
        
//        
//        var converter = CoordinateToCity()
//        
//        println("start")
//        println(converter.getCity("38.897946", long: "77.021927")) // For debugging purposes
//        println("end")
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesOfInterest.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        
        if (placesOfInterest.count == 0) { // Create empty cell
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        } else {
            if (indexPath.row < placesOfInterest.count) {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
                cell.textLabel.text = placesOfInterest[indexPath.row]
            }
        
        
        }
        
        return cell
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

