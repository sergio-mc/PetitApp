//
//  LoaderViewController.swift
//  petitui
//
//  Created by Sergio on 11/02/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit

class LoaderViewController: UIViewController {

    fileprivate var activityView : UIView?
    
    func showSpinner()
    {
        
        activityView = UIView(frame: self.view.bounds)
        activityView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = activityView!.center
        activityIndicator.startAnimating()
        activityView?.addSubview(activityIndicator)
        self.view.addSubview(activityView!)
    }
    
    func removeSpinner()
    {
        activityView?.removeFromSuperview()
        activityView = nil
    }

}
