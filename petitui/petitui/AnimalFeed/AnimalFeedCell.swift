//
//  AnimalFeedCell.swift
//  petitui
//
//  Created by Jose D. on 24/01/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import Foundation
import UIKit

//esta clase tambien necesita la super clase de collection view
class AnimalFeedCell: UICollectionViewCell {
    
    
    @IBOutlet weak var animalFeedImage: UIImageView!
    @IBOutlet weak var animalFeedName: UILabel!
    
    @IBOutlet weak var animalFeedAge: UILabel!
}
