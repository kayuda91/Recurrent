//
//  UIViewController+Gestures.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/15/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboardOnTap))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboardOnTap() {
        view.endEditing(true)
    }
}
