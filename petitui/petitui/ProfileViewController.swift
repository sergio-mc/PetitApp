//
//  ProfileViewController.swift
//  petitui
//
//  Created by user167367 on 3/7/20.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, MyDataSendingDelegateProtocol  {
    
    public var latitude : Double?
    public var longitude: Double?
    var user:User?
    
    func sendDataToRegisterVC(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSearchLocation"{
            let searchVC : SearchLocationViewController = segue.destination as! SearchLocationViewController
            searchVC.delegate = self
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let decoded  = UserDefaults.standard.object(forKey: "user")
        do {
            user = try JSONDecoder().decode(User.self, from: decoded as! Data)
            
        }
        catch  {
            
        }
        
    }
    
    
    
}
