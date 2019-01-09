//
//  UIView+Corners.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/8/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(radius: Float? = nil) {
        clipsToBounds = true
        layer.cornerRadius = radius != nil ? CGFloat(radius!) : min(bounds.height, bounds.width) / 2
    }
}
