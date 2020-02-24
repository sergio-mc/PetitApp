//
//  ProfileControllerViewController.swift
//  petitui
//
//  Created by user167367 on 2/24/20.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class ProfileController: UIViewController, CLLocationManagerDelegate {

    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("LOCALIZACION DE LA POLLA" , location.coordinate)
            
        
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        if (status == CLAuthorizationStatus.denied){
            showLocationDisablePopUp()
        }
    }
    
    
    func showLocationDisablePopUp(){
        let alertController = UIAlertController(title: "Background Location Access disable", message: "", preferredStyle: .alert)
        
        let cancelAction  = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default){
            (action) in if let url = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    



}
