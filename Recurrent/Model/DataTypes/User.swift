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
    var firstName: String?
    var lastName: String?
    var country: String?
    var zipCode: String?
    var addressLine1: String?
    var addressLine2: String?
    var city: String?
    var state: String?
    var createdAt: Timestamp?

    var serialized: [String : Any] {
        var values = [String : Any]()

        values[Field.identifier.stringRawValue] = identifier

        if let phoneNumber = phoneNumber {
            values[Field.phoneNumber.stringRawValue] = phoneNumber
        }
        
        if let passcode = passcode {
            values[Field.passcode.stringRawValue] = passcode
        }
        
        if let firstName = firstName {
            values[Field.firstName.stringRawValue] = firstName
        }
        
        if let lastName = lastName {
            values[Field.lastName.stringRawValue] = lastName
        }
        
        if let country = country {
            values[Field.country.stringRawValue] = country
        }
        
        if let zipCode = zipCode {
            values[Field.zipCode.stringRawValue] = zipCode
        }
        
        if let addressLine1 = addressLine1 {
            values[Field.addressLine1.stringRawValue] = addressLine1
        }
        
        if let addressLine2 = addressLine2 {
            values[Field.addressLine2.stringRawValue] = addressLine2
        }
        
        if let city = city {
            values[Field.city.stringRawValue] = city
        }
        
        if let state = state {
            values[Field.state.stringRawValue] = state
        }
        
        if let createdAt = createdAt {
            values[Field.createdAt.stringRawValue] = createdAt
        }
        
        return values
    }
    
    init(identifier: String,
         phoneNumber: String? = nil,
         passcode: String? = nil,
         firstName: String? = nil,
         lastName: String? = nil,
         country: String? = nil,
         zipCode: String? = nil,
         addressLine1: String? = nil,
         addressLine2: String? = nil,
         city: String? = nil,
         state: String? = nil,
         createdAt: Timestamp? = nil) {
        self.identifier = identifier
        self.phoneNumber = phoneNumber
        self.passcode = passcode
        self.firstName = firstName
        self.lastName = lastName
        self.country = country
        self.zipCode = zipCode
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.city = city
        self.state = state
        self.createdAt = createdAt
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
        case firstName
        case lastName
        case country
        case zipCode
        case addressLine1
        case addressLine2
        case city
        case state
        case createdAt
    }
}

// MARK: - Equatable
extension User: Equatable {
    static func ==(lhs: User,
                   rhs: User) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
