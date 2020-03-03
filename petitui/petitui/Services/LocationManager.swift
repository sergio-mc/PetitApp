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
        
        //DataHelpers.convertLatLongToAddress(latitude: locValue.latitude, longitude: locValue.longitude)
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
    
    static func convertLatLongToAddress(latitude:Double,longitude:Double){
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            
            // Location name
            let locationName = placeMark.location
            
            // Street address
            let street = placeMark.thoroughfare
            // Postal code
            
            let postalCode = placeMark.postalCode
            
            // City
            let city = placeMark.subAdministrativeArea
            // Zip code
            let zip = placeMark.isoCountryCode
            // Country
            let country = placeMark.country
            
            var address1 = String(street!) + ", " + String(city!)
            
            var address2 = ", " + String(postalCode!) + ", " + String(zip!)
            
            var address = address1 + address2
            
            print(address)
            
            self.getLatLongFromAddress(address: address)
        })
        
    }
    
    static func getLatLongFromAddress(address : String) {
        
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                
                var latitude =  coordinates.latitude
                var longitude = coordinates.longitude
                
                print("TRANSFORM", latitude)
                print("TRANSFORM", longitude)
                
            }
        })
        
    }
}
