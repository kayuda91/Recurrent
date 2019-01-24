//
//  FirestroreModel.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/23/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import Foundation
import FirebaseFirestore

// MARK: - Property definition
private struct Property {
    let label: String
    let value: Any
}

// MARK: - FirestoreModel
protocol FirestoreModel {
    init?(modelData: FirestoreModelData) throws
    
    var identifier: String { get }
    var serialized: [String : Any] { get }
}

extension Equatable where Self: FirestoreModel {
    static func ==(lhs: Self,
                   rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

extension FirestoreModel {
    var serialized: [String : Any] {
        var data = [String : Any]()
        
        Mirror(reflecting: self).children.forEach { child in
            guard let property = child.label.flatMap({ Property(label: $0, value: child.value) }) else {
                return
            }
            
            switch property.value {
            case let rawRepresentable as StringRawRepresentable:
                data[property.label] = rawRepresentable.stringRawValue
                
            default:
                data[property.label] = property.value
            }
        }
        
        return data
    }
}
