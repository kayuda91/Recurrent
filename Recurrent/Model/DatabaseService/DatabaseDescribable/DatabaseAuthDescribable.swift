//
//  DatabaseAuthDescribable.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/24/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import Foundation

protocol DatabaseAuthDescribable: class {
    var isAuthentificated: Bool { get }
    
    func signInAnonymously(completion: AuthSignInCallback?)
}

// MARK: - Callbacks
extension DatabaseAuthDescribable {
    typealias AuthSignInCallback = (User?, Error?) -> Void
}
