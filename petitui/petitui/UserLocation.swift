//
//  UserLocation.swift
//  petitui
//
//  Created by user167367 on 2/24/20.
//  Copyright © 2020 Sergio. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class UserLocation: CLLocationManagerDelegate{
    
    
    let locationManager = CLLocationManager()
    
    func viewDidLoad() {
    viewDidLoad()
     
        
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])-> (Double, Double) {
        if let location = locations.first {
            print(location.coordinate)
        }
    }
    
}
