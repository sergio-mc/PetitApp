//
//  CollectionViewCell.swift
//  petitui
//
//  Created by Sergio on 09/03/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit

class UserPetsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petRemove: UIButton!
    
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petAge: UILabel!
}
