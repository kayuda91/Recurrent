//
//  StringRawRepresentable.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/23/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import Foundation

protocol StringRawRepresentable {
    var stringRawValue: String { get }
}

// MARK: - Default implementation
extension StringRawRepresentable where Self: RawRepresentable, Self.RawValue == String {
    var stringRawValue: String {
        return rawValue
    }
}
