//
//  UIViewController+Extensions.swift
//  penguinpay-swift
//
//  Created by Yan Correa Trindade on 07/02/22.
//

import UIKit

extension UIViewController {
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var coordinator: AppCoordinator {
        return self.appDelegate.coordinator
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
