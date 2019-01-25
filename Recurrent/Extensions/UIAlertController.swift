//
//  UIAlertController.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/24/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(with title: String? = "Error", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(closeAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(with title: String?, message: String, cancelButtonName: String = "Cancel", okButtonName: String = "Ok", okAction: @escaping (() -> Void)) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: cancelButtonName, style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: okButtonName, style: .default) { _ in
            okAction()
        }
        
        alertController.addAction(closeAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
