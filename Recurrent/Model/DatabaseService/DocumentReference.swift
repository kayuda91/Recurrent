//
//  DocumentReference.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/23/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol DocumentTypedReferencable: class {
    func setObject(_ object: FirestoreModel)
    
    func getObject<Model: FirestoreModel>(_: Model.Type,
                                          completion: @escaping (Model?, Error?) -> Void)
}

// MARK: - DocumentTypedReferencable
extension DocumentReference: DocumentTypedReferencable {
    func setObject(_ object: FirestoreModel) {
        var documentData = [String : Any]()
        
        for (key, value) in object.serialized {
            if key == "documentID" {
                continue
            }
            
            switch value {
            case let rawRepresentable as StringRawRepresentable:
                documentData[key] = rawRepresentable.stringRawValue
                
            default:
                documentData[key] = value
            }
        }
        
        setData(documentData)
    }
    
    func getObject<Model: FirestoreModel>(_: Model.Type,
                                          completion: @escaping (Model?, Error?) -> Void) {
        getDocument { snapshot, error in
            if let error = error {
                completion(nil, error)
                
                return
            }
            
            guard let snapshot = snapshot else {
                completion(nil, nil)
                
                return
            }
            
            do {
                let object = try Model.init(modelData: FirestoreModelData(snapshot: snapshot))
                completion(object, nil)
            } catch {
                completion(nil, nil)
            }
        }
    }
}
