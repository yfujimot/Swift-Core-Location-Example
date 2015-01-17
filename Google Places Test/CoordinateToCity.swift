//
//  CoordinateToCity.swift
//  Google Places Test
//
//  Created by Yoshio Fujimoto on 1/17/15.
//  Copyright (c) 2015 ThinkFuji. All rights reserved.
//

import Foundation

class CoordinateToCity {
    
    let latitude = "38.897946"
    let longtitude = "-77.021927"
    
    
    
    func getCity(lat: String, long: String) -> String {
        let urlString: String = "http://www.latlong.net/c/?lat=\(lat)&long=\(long)"
        
        let url = NSURL(string: urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        
        task.resume()
        
        return urlString
    }
    
}