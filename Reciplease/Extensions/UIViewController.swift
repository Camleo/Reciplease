//
//  UIViewController.swift
//  Reciplease
//
//  Created by rochdi ben abdeljelil on 03.08.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - Methodes
    
    /// method to display an alert
    func alert(message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
    }
    /// method called to manage button and activity controller together: true to hide button and show acticity indicator / false to show button and hide activity controller
       func manageActivityIndicator(activityIndicator: UIActivityIndicatorView, button: UIButton, showActivityIndicator: Bool){
           activityIndicator.isHidden = !showActivityIndicator
           button.isHidden = showActivityIndicator
       }
    /// method to load data from url
       func loadImageDataFromUrl(stringImageUrl: String) -> Data{
           guard let imageUrl = URL(string: stringImageUrl) else {return Data()}
           guard let data = try? Data(contentsOf: imageUrl) else {return Data()}
           return data
       }
}

