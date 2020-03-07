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

    func sendDataToRegisterVC(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
      @IBAction func saveChanges(_ sender: Any) {
        
        if latitude != nil && longitude != nil {
            ApiManager.updateLatLongUser(id: 1, latitude: latitude!, longitude: longitude!){
                      response in print("Response updated Latitude and Longitude",response)
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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
