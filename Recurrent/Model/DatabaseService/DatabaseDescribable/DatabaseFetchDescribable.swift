//
//  DatabaseFetchDescribable.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/23/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol DatabaseFetchDescribable: class {
    func fetchUser(for userIdentifier: String,
                   completion: FetchUserCallback?)
    
    func fetchUsers(completion: FetchUsersCallback?)
}

// MARK: - Callbacks
extension DatabaseFetchDescribable {
    typealias FetchUserCallback = (User?, Error?) -> Void
    typealias FetchUsersCallback = ([User]?, Error?) -> Void
}
