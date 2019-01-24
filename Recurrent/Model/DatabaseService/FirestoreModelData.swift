//
//  FirestoreModelData.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/23/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct FirestoreModelData {
    let snapshot: DocumentSnapshot
    
    var documentID: String {
        return snapshot.documentID
    }
    
    var data: [String : Any] {
        return snapshot.exists ? (snapshot.data() ?? [:]) : [:]
    }
    
    func value<T>(forKey key: String) throws -> T {
        guard let value = data[key] as? T else {
            throw ModelDataError.typeCastFailed
        }
        
        return value
    }
    
    func value<T: RawRepresentable>(forKey key: String) throws -> T where T.RawValue == String {
        guard let value = data[key] as? String else {
            throw ModelDataError.typeCastFailed
        }
        
        return T(rawValue: value)!
    }
    
    func optionalValue<T>(forKey key: String) -> T? {
        return data[key] as? T
    }
    
    enum ModelDataError: Error {
        case typeCastFailed
    }
}
