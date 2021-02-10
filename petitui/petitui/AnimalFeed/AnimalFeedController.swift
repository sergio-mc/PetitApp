//
//  AnimalFeedController.swift
//  petitui
//
//  Created by Jose D. on 24/01/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//


import UIKit


class AnimalFeedController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate      {
    @IBOutlet weak var titleNewPets: UILabel!
    
    @IBOutlet weak var barItem: UITabBarItem!
    
    
    @IBOutlet weak var dogFilter: UIButton!
    @IBOutlet weak var catFilter: UIButton!
    @IBOutlet weak var otherFilter: UIButton!
    
    
    
    
    @IBAction func dogFilterButton(_ sender: Any) {
        changeTypeButtonsBorder(dog:3)
        filterAnimalsModel.type = "dog"
        updateGridFilterd()
        
        
        
    }
    @IBAction func catFilterButton(_ sender: Any) {
        changeTypeButtonsBorder(cat:3)
        filterAnimalsModel.type = "cat"
        updateGridFilterd()
        
    }
    
    @IBAction func otherFilterButton(_ sender: Any) {
        changeTypeButtonsBorder(other:3)
        filterAnimalsModel.type = "other"
        updateGridFilterd()
        
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        self.viewDidLoad()
        self.viewWillAppear(true)
        updateGridFilterd()
    }
    @IBAction func resetFilters(_ sender: Any) {
        filterSelecter.setTitle("Breed", forSegmentAt: 0)
        filterSelecter.setTitle("Distance", forSegmentAt: 1)
        filterSelecter.setTitle("Age", forSegmentAt: 2)
        filterText.text = ""
        filterSearchBar.text = ""
        filterDistanceSlider.value = 0
        filterAgeSlider.value = 0
        filterAnimalsModel.type = nil
        filterAnimalsModel.breed = nil
        filterAnimalsModel.age = nil
        filterAnimalsModel.distance = nil
        self.viewDidLoad()
        self.viewWillAppear(true)
        updateGridFilterd()
        
        
    }
    
    
    var filterAnimalsModel : FilterAnimalsModel = FilterAnimalsModel()
    var petsFeed:[Pet] = []
    var user: User?
    @IBOutlet weak var filterText: UILabel!
    @IBOutlet weak var filterSearchBar: UITextField!
    @IBOutlet weak var filterDistanceSlider: UISlider!
    
    @IBOutlet weak var filterSelecter: UISegmentedControl!
    
    @IBOutlet weak var filterAgeSlider: UISlider!
    
    @IBOutlet weak var petsCollectionView: UICollectionView!
    
    @IBAction func onChangeBreedInput(_ sender: Any) {
        setCollectionViewPosition()
        let currentValue: String = (sender as AnyObject).text
        filterText.text = "Breed: \(currentValue)"
        filterSelecter.setTitle("Breed: \(currentValue)", forSegmentAt: 0)
        filterAnimalsModel.breed = currentValue
        updateGridFilterd()
    }
    
    
    @IBAction func onChangeDistanceSlider(_ sender: UISlider) {
        setCollectionViewPosition()
        let currentValue = Int(sender.value)
        filterText.text = "Distance: \(currentValue) km"
        filterSelecter.setTitle("Distance: \(currentValue) km", forSegmentAt: 1)
    }
    
    @IBAction func onChangeAgeSlider(_ sender: UISlider) {
        setCollectionViewPosition()
        let currentValue = Int(sender.value)
        filterText.text = "Age: \(currentValue)"
        filterSelecter.setTitle("Age: \(currentValue)", forSegmentAt: 2)
    }
    
    @IBAction func editingEndDistance(_ sender: UISlider) {
        filterAnimalsModel.distance=Int(sender.value)
        updateGridFilterd()
        
    }
    
    @IBAction func editingEndAge(_ sender: UISlider) {
        filterAnimalsModel.age=Int(sender.value)
        updateGridFilterd()
        
    }
    
    
    @IBAction func filterSwitch(controller sender: Any) {
        setCollectionViewPosition()
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
        if(petsFeed.isEmpty)
        {
            let defaultImage : UIImageView = {
                let iv = UIImageView()
                iv.image = UIImage(named:"defaultCV")
                iv.contentMode = .center
                return iv
            }()
            self.petsCollectionView.backgroundView = defaultImage
            self.petsCollectionView.backgroundColor = nil
            return 0
        }else{
            self.petsCollectionView.backgroundView = nil
            self.petsCollectionView.backgroundColor = UIColor(red:242/255, green:242/255, blue:242/255, alpha: 1)
            return petsFeed.count
        }
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.petsCollectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! AnimalFeedCell
        
        cell.petName.text = petsFeed[indexPath.row].name
        cell.petAge.text = "\(String(petsFeed[indexPath.row].age)) years"
        cell.petImage.image = UIImage.init(imageLiteralResourceName: "sloth")
        ApiManager.getImage(url:petsFeed[indexPath.row].preferedPhoto){
            (data) in
            if let picture=data {
                cell.petImage.image = UIImage(data: picture)
            }
            
            
        }
        
        cell.layer.borderColor = UIColor(red:220/255, green:220/255, blue:220/255, alpha: 0.75).cgColor
        cell.layer.borderWidth = 0.5
        cell.petName.layer.addBorder(edge: UIRectEdge.top, color: UIColor.red, thickness: 0.5)
        cell.layer.cornerRadius = 20
        cell.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        // Set background from collectionview into an image
        //        let defaultImage : UIImageView = {
        //            let iv = UIImageView()
        //            iv.image = UIImage(named:"beagle")
        //            iv.contentMode = .scaleAspectFill
        //            return iv
        //        }()
        //        self.petsCollectionView.backgroundView = defaultImage
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let decoded  = UserDefaults.standard.object(forKey: "user")
        do {
            user = try JSONDecoder().decode(User.self, from: decoded as! Data)
            filterAnimalsModel.longitude = user?.longitude
            filterAnimalsModel.latitude = user?.latitude

            }catch  {
                
            }
        
        self.hideKeyboardWhenTappedAround()
        ApiManager.getFeedAnimals(){pets in
            self.petsFeed=pets
            self.petsCollectionView.reloadData()
        }
        
        self.petsCollectionView.dataSource = self
        self.petsCollectionView.delegate = self
        
        setColorAndWidth(button: dogFilter)
        setColorAndWidth(button: catFilter)
        setColorAndWidth(button: otherFilter)
        
        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 0
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
    }
    
    override func viewDidLayoutSubviews() {
        if(filterSelecter.selectedSegmentIndex < 0){
            titleNewPets.frame.origin.y = 320
            petsCollectionView.frame.origin.y = 350
        }else{
            setCollectionViewPosition()
        }
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        filterText.text = ""
        filterSearchBar.isHidden = true
        filterDistanceSlider.isHidden = true
        filterAgeSlider.isHidden = true
        filterSelecter.selectedSegmentIndex -= 3;
        titleNewPets.frame.origin.y = 320
        petsCollectionView.frame.origin.y = 350
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = (sender as? AnimalFeedCell)
        let indexPath = self.petsCollectionView.indexPath(for: item!)
        let cell = petsCollectionView.cellForItem(at: indexPath!) as? AnimalFeedCell
        let selectedPed=petsFeed[indexPath?.row ?? 0]
        let detailPetView = segue.destination as! DetailAnimalViewController
        let selectedPetID=petsFeed[indexPath?.row ?? 0].id
        detailPetView.detailPet = selectedPed
        detailPetView.detailImage=cell?.petImage
        detailPetView.detailPetID = selectedPetID
        
        
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        //        if gesture.direction == .right {
        //            print("Swipe Right")
        //        }
        //        else if gesture.direction == .left {
        //            print("Swipe Left")
        //        }
        //        else if gesture.direction == .up {
        //            print("Swipe Up")
        //        }
        if gesture.direction == .down {
            // Recargar datos cuando sabemos que la base de datos esta actualizada
            self.viewDidLoad()
            self.viewWillAppear(true)
        }
    }
    
    func setCollectionViewPosition()
    {
        titleNewPets.frame.origin.y = 360
        petsCollectionView.frame.origin.y = 390
    }
    
    func updateGridFilterd() {
        
        ApiManager.getAnimalsFilters(filterAnimalModel: filterAnimalsModel ){
            filteredPets in
            self.petsFeed=filteredPets
            self.petsCollectionView.reloadData()
            self.petsCollectionView.setContentOffset(CGPoint.zero, animated: true)
        }
        
    }
    
    func changeTypeButtonsBorder(dog:CGFloat = 0,cat:CGFloat = 0,other:CGFloat = 0) {
        dogFilter.layer.borderWidth = dog
        catFilter.layer.borderWidth = cat
        otherFilter.layer.borderWidth = other
        
    }
    func setColorAndWidth(button:UIButton)  {
        button.layer.borderWidth = 0
        button.layer.borderColor = UIColor(red:163/255, green:209/255, blue:204/255, alpha: 1).cgColor     }
    
    
}



extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: -5, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: UIScreen.main.bounds.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = UIColor.lightGray.cgColor
        
        self.addSublayer(border)
    }
    
}
