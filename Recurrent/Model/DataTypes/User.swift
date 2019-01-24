//
//  User.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/23/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import Foundation
import FirebaseFirestore

final class User {
    var identifier: String
    var phoneNumber: String?

    var serialized: [String : Any] {
        var values = [String : Any]()

        values[Field.identifier.stringRawValue] = identifier

        if let phoneNumber = phoneNumber {
            values[Field.phoneNumber.stringRawValue] = phoneNumber
        }
        
        return values
    }
    
    init(identifier: String,
         phoneNumber: String? = nil) {
        self.identifier = identifier
        self.phoneNumber = phoneNumber
    }
    
    init?(modelData: FirestoreModelData) throws {
        guard modelData.snapshot.exists else {
            return nil
        }
        
        identifier = modelData.documentID
        phoneNumber = modelData.optionalValue(forKey: Field.phoneNumber.stringRawValue)
    }
}

// MARK: - FirestoreModel
extension User: FirestoreModel {
    enum Field: String, StringRawRepresentable {
        case identifier
        case phoneNumber
    }
}

// MARK: - Equatable
extension User: Equatable {
    static func ==(lhs: User,
                   rhs: User) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
