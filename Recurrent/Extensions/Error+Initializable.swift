//
//  Error+Initializable.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/23/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import Foundation

extension NSError {
    static func error(from message: String) -> NSError {
        return NSError(domain: String(), code: 0, userInfo: [NSLocalizedDescriptionKey : message])
    }
}
