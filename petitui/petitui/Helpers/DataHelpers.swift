//
//  DataHelpers.swift
//  petitui
//
//  Created by Jose D. on 22/01/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
//Displays an alert with a message depending on the string passed through parameters
class DataHelpers{
    
    static func displayAlert(userMessage:String, alertType: Int)->UIAlertController{
        let alertTitle: String
        
        if (alertType == 0) {
            alertTitle = "There was an error!"
        } else {
            alertTitle = "Nice!"
        }
        
        let alert = UIAlertController(title: alertTitle, message: userMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        return alert
        //       self.present(alert, animated: true, completion: nil)
        
    }
    
    //
    static func isUsernameValid(_ username: String) -> Bool {
        return true
    }
    
    //
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //
    static func isValidPassword(_ password: String) -> Bool {
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passPred.evaluate(with: password)
    }
    
    static func isValidage(_ age: String) -> Bool {
           let passRegEx = "^[0-9]+$"
           
           let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
           return passPred.evaluate(with: age)
       }
    
    //
    static func isValidRepeatedPassword(_ repeatedPassword: String , _ userPassword : String) -> Bool {
        return userPassword == repeatedPassword
    }
    
    static func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
          print("COORDINATES = \(locValue.latitude) \(locValue.longitude)")
          
          
          
          convertLatLongToAddress(latitude: locValue.latitude, longitude: locValue.longitude)
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

