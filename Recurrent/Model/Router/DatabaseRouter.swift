//
//  DatabaseRouter.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/23/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol DatabaseRouterable: class {
    var rootFirestore: Firestore { get }
    
    func usersCollectionRoute() -> CollectionReference
    
    func userRoute(_ userIdentifier: String) -> DocumentReference
}

final class DatabaseRouter {
    var rootFirestore: Firestore {
        return Firestore.firestore()
    }
}

// MARK: - DatabaseRouterable
extension DatabaseRouter: DatabaseRouterable {
    func usersCollectionRoute() -> CollectionReference {
        return rootFirestore.collection("users")
    }
    
    func userRoute(_ userIdentifier: String) -> DocumentReference {
        return usersCollectionRoute().document(userIdentifier)
    }
}
