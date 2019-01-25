//
//  DatabaseSaveDescribable.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/23/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol DatabaseSaveDescribable: class {
    func save(user: User,
              completion: CommonSaveOperationCallback?)
}

// MARK: - Callbacks
extension DatabaseSaveDescribable {
    typealias CommonSaveOperationCallback = (Bool, Error?) -> Void
}
