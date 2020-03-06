//
//  SearchLocationViewController.swift
//  petitui
//
//  Created by alumnos on 05/03/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit
import MapKit


protocol MyDataSendingDelegateProtocol{
    func sendDataToRegisterVC(latitude: Double, longitude: Double)
}

class SearchLocationViewController: UIViewController {
    
    var searchCompleter = MKLocalSearchCompleter()
    
    var searchResults = [MKLocalSearchCompletion]()
    
    var delegate : MyDataSendingDelegateProtocol? = nil
    
    @IBOutlet weak var searchResultsTablevIEW: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        searchCompleter.delegate = self
        
        searchResultsTablevIEW.delegate = self
        
    }
}



extension SearchLocationViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchCompleter.queryFragment = searchText
    }
    
}



extension SearchLocationViewController: MKLocalSearchCompleterDelegate {
    
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        
        searchResults = completer.results
        
        searchResultsTablevIEW.reloadData()
        
    }
    
    
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        
        // handle error
        
    }
    
    
    
}



extension SearchLocationViewController: UITableViewDataSource {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let searchResult = searchResults[indexPath.row]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = searchResult.title
        
        cell.detailTextLabel?.text = searchResult.subtitle
        
        return cell
        
    }
    func dismissSearch(latitude : Double , longitude : Double){
        if self.delegate != nil{
            self.delegate?.sendDataToRegisterVC(latitude: latitude, longitude: longitude)
            dismiss(animated: true, completion: nil)
        }
    }
    
}


extension SearchLocationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        let completion = searchResults[indexPath.row]

        let searchRequest = MKLocalSearch.Request(completion: completion)
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { (response, error) in
            
            let coordinate = response?.mapItems[0].placemark.coordinate
            
            print(String(describing: coordinate))
            print("BaD bUNNNNY", response?.mapItems[0].placemark)
            
            var latitude : Double = Double(coordinate!.latitude)
            
            var longitude : Double = Double(coordinate!.longitude)
            
          //  convertLatLongToAddress(latitude: latitude, longitude: longitude)
          self.dismissSearch(latitude: latitude, longitude: longitude)
        }
    }
}


func convertLatLongToAddress(latitude:Double,longitude:Double){

    let geoCoder = CLGeocoder()
    
    let location = CLLocation(latitude: latitude, longitude: longitude)
    
    geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
        
        // Place details
        
        var placeMark: CLPlacemark!
        
        placeMark = placemarks?[0]
        print("FIDI AUTOESCUELAS", placeMark)
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
        var address1 = String(street ?? "") + ", " + String(city ?? "")
        var address2 = ", " + String(postalCode ?? "") + ", " + String(zip ?? "")
        var address = address1 + address2
        print(address)
        getLatLongFromAddress(address: address)
        
    })
}



func getLatLongFromAddress(address : String) {
    let geocoder = CLGeocoder()
    
    var latitude: Double?
    var longitude: Double?
    
    geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
        
        if((error) != nil){
            print("Error", error)
        }
        
        if let placemark = placemarks?.first {
            
            let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
            
            latitude =  coordinates.latitude
            
            longitude = coordinates.longitude
            
            ApiManager.updateLatLongUser(id: 1, latitude: latitude!, longitude: longitude!){
                response in print("Response updated Latitude and Longitude",response)
            }
            print("TRANSFORM", latitude)
            print("TRANSFORM", longitude)
  
        }
    })
}
