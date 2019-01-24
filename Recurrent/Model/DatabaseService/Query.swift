//
//  Query.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/23/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol TypableQuery: class {
    func getObjects<Model: FirestoreModel>(_: Model.Type,
                                           completion: @escaping ([Model]?, Error?) -> Void)
}

// MARK: - TypableQuery
extension Query: TypableQuery {
    func getObjects<Model: FirestoreModel>(_: Model.Type,
                                           completion: @escaping ([Model]?, Error?) -> Void) {
        getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
                
                return
            }
            
            guard let snapshot = snapshot else {
                completion(nil, nil)
                
                return
            }
            
            do {
                let objects = try snapshot.documents
                    .compactMap {
                        try Model.init(modelData: FirestoreModelData.init(snapshot: $0))
                }
                
                completion(objects, nil)
            } catch {
                completion(nil, nil)
            }
        }
    }
}
