//
//  UIViewControllerEx.swift
//  RememberMe
//
//  Created by Joao Anjos on 05/04/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit

extension UIViewController{
    func showMessage(message: String, title: String) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

}
