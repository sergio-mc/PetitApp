//
//  LaunchViewController.swift
//  petitui
//
//  Created by Sergio on 20/02/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        logo.transform = CGAffineTransform.identity
        logo.transform = CGAffineTransform(rotationAngle: -CGFloat.pi * 0.999)
    }
    

    

}
