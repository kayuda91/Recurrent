//
//  DatabaseService.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/23/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseCore

protocol DatabaseServicable : DatabaseSaveDescribable, DatabaseFetchDescribable {
    var router: DatabaseRouterable { get set }
    var userIdentifier: String? { get }
    
    static func configure()
}

final class DatabaseService {
    lazy var router: DatabaseRouterable = DatabaseRouter()
    
    var userIdentifier: String? {
        return ""//Auth.auth().currentUser?.uid
    }
}

// MARK: - Errors
extension DatabaseService {
    var noObjectsFoundError: Error? {
        return NSError.error(from: "There are no objects.")
    }
    
    var noObjectFoundError: Error? {
        return NSError.error(from: "There is no object.")
    }
}

// MARK: - DatabaseServicable
extension DatabaseService: DatabaseServicable {
    static func configure() {
        FirebaseApp.configure()
    }
}

// MARK: - DatabaseSaveDescribable
extension DatabaseService {
    func save(user: User,
              completion: DatabaseSaveDescribable.CommonSaveOperationCallback?) {
        router
            .userRoute(user.identifier)
            .setData(user.serialized) { error in
                completion?(error == nil, error)
        }
    }
}

// MARK: - DatabaseFetchDescribable
extension DatabaseService {
    func fetchUser(for userIdentifier: String,
                   completion: DatabaseFetchDescribable.FetchUserCallback?) {
        router
            .userRoute(userIdentifier)
            .getObject(User.self) { user, error in
                completion?(user, error)
        }
    }
    
    func fetchUsers(completion: DatabaseFetchDescribable.FetchUsersCallback?) {
        router
        .usersCollectionRoute()
            .getObjects(User.self) { users, error in
                completion?(users, error)
        }
    }
}
