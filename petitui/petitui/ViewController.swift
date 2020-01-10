//
//  ViewController.swift
//  petitui
//
//  Created by alumnos on 10/01/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Para el futuro, tenemos que ocultar el navigation bar cuando la pantalla sea la de registro, login o recover.
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }


}

