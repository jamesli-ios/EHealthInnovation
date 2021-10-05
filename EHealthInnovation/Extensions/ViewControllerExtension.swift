//
//  ViewControllerExtension.swift
//  EHealthInnovation
//
//  Created by James on 2021/10/4.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: AppConstants.Strings.ok, style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
