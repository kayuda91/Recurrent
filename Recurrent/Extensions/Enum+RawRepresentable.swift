//
//  Enum+RawRepresentable.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/11/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import Foundation

extension RawRepresentable where Self: Hashable {
    private static func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
        var i = 0
        
        return AnyIterator {
            let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
            
            if next.hashValue != i {
                return nil
            }
            
            i += 1
            
            return next
        }
    }
    
    static func getCases() -> [Self] {
        return iterateEnum(Self.self).map{$0}
    }
    
    static var count: Int {
        return getCases().count
    }
    
    static func getRawValues() -> [RawValue] {
        let arr = getCases()
        let rawValues = arr.compactMap {
            $0.rawValue
        }
        
        return rawValues
    }
}
