//
//  ProfileViewController.swift
//  petitui
//
//  Created by Sergio on 09/03/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//
import UIKit
import CoreLocation

class ProfileViewController: UIViewController, MyDataSendingDelegateProtocol{
    
    @IBAction func userPets(_ sender: Any) {
        self.segueUserPets()
    }
      func sendDataToRegisterVC(latitude: Double, longitude: Double) {
          self.latitude = latitude
           self.longitude = longitude
       }
    
    var user: User?
       public var latitude : Double?
        public var longitude: Double?
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    
    @IBOutlet weak var inputNewEmail: UITextField!
    
    @IBAction func emailButton(_ sender: Any) {
        if(inputNewEmail.isHidden)
        {
            inputNewEmail.isHidden = false
        }else{
            inputNewEmail.isHidden = true
        }
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        let decoded  = UserDefaults.standard.object(forKey: "user")
        self.userImage.image = UIImage(imageLiteralResourceName: "dog")
        do {
            user = try JSONDecoder().decode(User.self, from: decoded as! Data)
            if let userPicture = user?.picture{
                ApiManager.getImage(url: userPicture){
                    
                    response in
                    if let picture = response{
                        self.userImage.image = UIImage(data: picture)
                    }
                    
                    
                }
            }
            
            self.userName.text = user?.userName
            self.userEmail.text = user?.email
            let userLat = (user?.latitude as! NSString).doubleValue
            let userLon = (user?.longitude as! NSString).doubleValue
            if(userLat != nil && userLon != nil){convertLatLongToAddress(latitude: userLat, longitude: userLon)}
            else{
                self.userLocation.text = "Location"
            }
            
            
        }
        catch  {
            
        }
        
    }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toSearchLocation"{
                let searchVC : SearchLocationViewController = segue.destination as! SearchLocationViewController
                searchVC.delegate = self
            }
        }
    
    @IBAction func saveChanges(_ sender: Any) {
    
            if latitude != nil && longitude != nil  {
                if let userId = user?.id{
                    ApiManager.updateLatLongUser(id: userId, latitude: latitude!, longitude: longitude!){
                        response in print("Response updated Latitude and Longitude",response)
                    }
    
                }
            }else{
                self.present(DataHelpers.displayAlert(userMessage: "The changes haven't been updated", alertType: 0), animated: true, completion: nil)
            }
    
        }
    
    
    func segueUserPets()  {
        performSegue(withIdentifier: "userPets", sender: nil)
    }
    
    func convertLatLongToAddress(latitude:Double,longitude:Double){
        
        let geoCoder = CLGeocoder()
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            
            var placeMark: CLPlacemark!
            var adressArray=[String]()
            placeMark = placemarks?[0]
            // Street address
            adressArray.append(String(placeMark.thoroughfare ?? ""))
            
            adressArray.append(String( placeMark.administrativeArea ?? ""))
            
            adressArray.append(String( placeMark.country ?? ""))
            var address=""
            
            for (index, item) in adressArray.enumerated() {
              print("Item \(index): \(item)")
                if(index == 0){ address += item }
                if(index == 1){ address += " ( \(item)/" }
                if(index == 2){ address += "\(item) )"}
                
            }
            
            self.userLocation.text = address
        })
    }
}

//
//  ProfileViewController.swift
//  petitui
//
//  Created by user167367 on 3/7/20.
//  Copyright © 2020 Sergio. All rights reserved.
//

//import UIKit
//
//class ProfileViewController: UIViewController, MyDataSendingDelegateProtocol  {
//
//    public var latitude : Double?
//    public var longitude: Double?
//    var user:User?
//
//    func sendDataToRegisterVC(latitude: Double, longitude: Double) {
//        self.latitude = latitude
//        self.longitude = longitude
//    }
//
//
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toSearchLocation"{
//            let searchVC : SearchLocationViewController = segue.destination as! SearchLocationViewController
//            searchVC.delegate = self
//        }
//    }
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let decoded  = UserDefaults.standard.object(forKey: "user")
//        do {
//            user = try JSONDecoder().decode(User.self, from: decoded as! Data)
//
//        }
//        catch  {
//
//        }
//
//    }
//
//
//
//}
