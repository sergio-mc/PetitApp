//
//  LocationManager.swift
//  petitui
//
//  Created by alumnos on 03/03/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class LocationService  : NSObject, CLLocationManagerDelegate {
    
    private static var locationManager: CLLocationManager?
    
    private static var locations: [CLLocation]?
    
    static func initService (){
        
        if(locationManager == nil){
            self.locationManager = CLLocationManager()
        }
        
        self.locationManager?.requestAlwaysAuthorization()
        self.locationManager?.requestWhenInUseAuthorization()
        
        
        self.checkPermission()
    }
    
    static func checkPermission(){
        if(!CLLocationManager.locationServicesEnabled()){
            print("Necesitas los permisos")
        }else{
            
        }
    }
    
    static func getLocations()-> [CLLocation]? {
        return self.locations
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        LocationService.locations = locations
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("COORDINATES = \(locValue.latitude) \(locValue.longitude)")
        
        DataHelpers.convertLatLongToAddress(latitude: locValue.latitude, longitude: locValue.longitude)
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
