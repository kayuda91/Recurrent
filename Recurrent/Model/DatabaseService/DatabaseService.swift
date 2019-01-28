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
import FirebaseAuth

protocol DatabaseServicable : DatabaseSaveDescribable, DatabaseFetchDescribable {
    var router: DatabaseRouterable { get set }
    var userIdentifier: String? { get }
    
    static func configure()
}

final class DatabaseService {
    lazy var router: DatabaseRouterable = DatabaseRouter()
    
    var userIdentifier: String? {
        return Auth.auth().currentUser?.uid
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

// MARK: - DatabaseAuthDescribable
extension DatabaseService {
    func signInAnonymously(completion: DatabaseAuthDescribable.AuthSignInCallback?) {
        Auth.auth().signInAnonymously { authResult, error in
            guard let userId = authResult?.user.uid else {
                completion?(nil, error)
                return
            }

            completion?(User(identifier: userId), error)
        }
    }
    
    func signOut(completion: DatabaseAuthDescribable.AuthSignOutCallback?) {
        do {
            try Auth.auth().signOut()
            completion?(true, nil)
        } catch let error {
            completion?(false, error)
        }
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
    
    func fetchUsersSortedByDate(completion: DatabaseFetchDescribable.FetchUsersCallback?) {
        router
            .usersCollectionRoute()
            .order(by: User.Field.createdAt.stringRawValue, descending: false)
            .getObjects(User.self) { users, error in
                completion?(users, error)
        }
    }
}
