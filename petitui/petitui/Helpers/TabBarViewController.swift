//
//  TabBarViewController.swift
//  petitui
//
//  Created by Sergio on 06/02/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit
import CoreLocation
class TabBarViewController: UITabBarController, CLLocationManagerDelegate{

    var locations : [CLLocation]?
    private var locationManager : CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.locationManager == nil {
            self.locationManager = CLLocationManager()
            self.locationManager?.delegate = self
            self.locationManager?.requestAlwaysAuthorization()
        }
    
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                self.locations = locations
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch (status) {
            
        case .notDetermined:
            print("")
            break
        case .restricted:
            print("")
            break
        case .denied:
            print("")
            break
        case .authorizedAlways:
            print("")
            break
        case .authorizedWhenInUse:
            print("")
            break
        @unknown default:
            print("")
            break
        }
}
}
