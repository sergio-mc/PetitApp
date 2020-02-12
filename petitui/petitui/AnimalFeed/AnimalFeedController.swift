//
//  AnimalFeedController.swift
//  petitui
//
//  Created by Jose D. on 24/01/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//


import UIKit


class AnimalFeedController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var dogFilter: UIButton!
    @IBOutlet weak var catFilter: UIButton!
    @IBOutlet weak var otherFilter: UIButton!

    
    @IBAction func dogFilterButton(_ sender: Any) {
        dogFilter.layer.borderWidth = 2
        catFilter.layer.borderWidth = 0
        otherFilter.layer.borderWidth = 0
        
        // Recargar datos cuando sabemos que la base de datos esta actualizada
        /*self.viewDidLoad()
        self.viewWillAppear(true)*/
    }
    @IBAction func catFilterButton(_ sender: Any) {
        dogFilter.layer.borderWidth = 0
        catFilter.layer.borderWidth = 2
        otherFilter.layer.borderWidth = 0
    }
    
    @IBAction func otherFilterButton(_ sender: Any) {
        dogFilter.layer.borderWidth = 0
        catFilter.layer.borderWidth = 0
        otherFilter.layer.borderWidth = 2
    }
    
    
    var petsFeed:[Pet] = []
    @IBOutlet weak var filterText: UILabel!
    @IBOutlet weak var filterSearchBar: UITextField!
    @IBOutlet weak var filterDistanceSlider: UISlider!
    
    @IBOutlet weak var filterSelecter: UISegmentedControl!
    
    @IBOutlet weak var filterAgeSlider: UISlider!
    
    @IBOutlet weak var petsCollectionView: UICollectionView!
    
    @IBAction func onChangeBreedInput(_ sender: Any) {
        let currentValue: String = (sender as AnyObject).text
        filterText.text = "Breed: \(currentValue)"
        filterSelecter.setTitle("Breed: \(currentValue)", forSegmentAt: 0)
    }
    
    
    @IBAction func onChangeDistanceSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        filterText.text = "Distance: \(currentValue) km"
        filterSelecter.setTitle("Distance: \(currentValue) km", forSegmentAt: 1)
    }
    
    @IBAction func onChangeAgeSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        filterText.text = "Age: \(currentValue)"
        filterSelecter.setTitle("Age: \(currentValue)", forSegmentAt: 2)
    }
    
    
    @IBAction func filterSwitch(controller sender: Any) {
        switch filterSelecter.selectedSegmentIndex {
        case 0:
            
            filterSearchBar.isEnabled = true
            filterSearchBar.isHighlighted = true
            filterText.isHidden = true
            filterSearchBar.isHidden = false
            filterDistanceSlider.isHidden = true
            filterAgeSlider.isHidden = true
            break
        case 1:
            
            filterSearchBar.isHighlighted = false
            filterSearchBar.isEnabled = false
            filterText.text = "Distance: 0"
            filterDistanceSlider.value = 0
            filterText.isHidden = false
            filterSearchBar.isHidden = true
            filterDistanceSlider.isHidden = false
            filterAgeSlider.isHidden = true
            break
        case 2:
            filterSearchBar.isHighlighted = false
            filterSearchBar.isEnabled = false
            filterText.text = "Age: 0"
            filterAgeSlider.value = 0
            filterText.isHidden = false
            filterSearchBar.isHidden = true
            filterDistanceSlider.isHidden = true
            filterAgeSlider.isHidden = false
            break
        default:
            filterText.isHidden = false
            filterSearchBar.isHidden = false
            filterDistanceSlider.isHidden = false
            filterAgeSlider.isHidden = false
        }
    }
 

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petsFeed.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.petsCollectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! AnimalFeedCell
        
        
        cell.petName.text = petsFeed[indexPath.row].name
        cell.petAge.text = String(petsFeed[indexPath.row].age)
        ApiManager.getImage(url:petsFeed[indexPath.row].preferedPhoto){
            (data) in
            cell.petImage.image = UIImage(data: data)
        }
        
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiManager.getFeedAnimals(){pets in
            self.petsFeed=pets
            self.petsCollectionView.reloadData()
        }
        self.petsCollectionView.dataSource = self
        self.petsCollectionView.delegate = self
        
        dogFilter.layer.borderColor = UIColor(red:163/255, green:209/255, blue:204/255, alpha: 1).cgColor
        dogFilter.layer.borderWidth = 0
        
        catFilter.layer.borderColor = UIColor(red:163/255, green:209/255, blue:204/255, alpha: 1).cgColor
        catFilter.layer.borderWidth = 0
        
        otherFilter.layer.borderColor = UIColor(red:163/255, green:209/255, blue:204/255, alpha: 1).cgColor
        otherFilter.layer.borderWidth = 0
        
        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 0
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        filterText.text = ""
        filterSelecter.selectedSegmentIndex -= 1;
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = (sender as? AnimalFeedCell)
        
        let indexPath = self.petsCollectionView.indexPath(for: item!)
        let cell = petsCollectionView.cellForItem(at: indexPath!) as? AnimalFeedCell 
            
        
        let selectedPed=petsFeed[indexPath?.row ?? 0]
        let detailPetView = segue.destination as! DetailAnimalViewController
        detailPetView.detailPet = selectedPed
        detailPetView.detailImage=cell?.petImage
        
    }
    
    
}
