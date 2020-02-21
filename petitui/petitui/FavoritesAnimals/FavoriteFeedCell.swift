//
//  FavoriteFeedCell.swift
//  petitui
//
//  Created by Sergio on 21/02/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit
import FaveButton

class FavoriteFeedCell: UICollectionViewCell{
    
    @IBOutlet weak var cellUIView: UIView!
    
    @IBOutlet weak var petImage: UIImageView!
    
    @IBOutlet weak var petFavorite: FaveButton!
    
    @IBOutlet weak var petName: UILabel!
    
    @IBOutlet weak var petAge: UILabel!
    
    @IBAction func petIsFavorite(_ sender: Any) {
        
    }
    
}




