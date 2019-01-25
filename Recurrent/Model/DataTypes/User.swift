//
//  User.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/23/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class User {
    var identifier: String
    var phoneNumber: String?
    var passcode: String?

    var serialized: [String : Any] {
        var values = [String : Any]()

        values[Field.identifier.stringRawValue] = identifier

        if let phoneNumber = phoneNumber {
            values[Field.phoneNumber.stringRawValue] = phoneNumber
        }
        
        if let passcode = passcode {
            values[Field.passcode.stringRawValue] = passcode
        }
        
        return values
    }
    
    init(identifier: String,
         phoneNumber: String? = nil,
         passcode: String? = nil) {
        self.identifier = identifier
        self.phoneNumber = phoneNumber
        self.passcode = passcode
    }
    
    init?(modelData: FirestoreModelData) throws {
        guard modelData.snapshot.exists else {
            return nil
        }
        
        identifier = modelData.documentID
        phoneNumber = modelData.optionalValue(forKey: Field.phoneNumber.stringRawValue)
        passcode = modelData.optionalValue(forKey: Field.passcode.stringRawValue)
    }
}

// MARK: - FirestoreModel
extension User: FirestoreModel {
    enum Field: String, StringRawRepresentable {
        case identifier
        case phoneNumber
        case passcode
    }
}

// MARK: - Equatable
extension User: Equatable {
    static func ==(lhs: User,
                   rhs: User) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
