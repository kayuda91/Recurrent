//
//  CALayer+Shadow.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/8/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import UIKit

extension CALayer {
    func addShadow(color: UIColor, offset: CGSize, opacity: CGFloat, radius: CGFloat) {
        shadowColor = color.cgColor
        shadowOffset = offset
        shadowOpacity = Float(opacity)
        shadowRadius = radius
    }
}
