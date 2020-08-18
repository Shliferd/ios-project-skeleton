//
//  KeyStore.swift
//  Core
//
//  Created by Matea Andrei on 8/18/20.
//  Copyright © 2020 Matea Andrei. All rights reserved.
//

import Foundation

private enum Key {
    static let accessToken = "accessToken"
}

public enum KeyStore {
    
    public enum Session {
        
        // MARK: - Properties
        
        @KeychainItem(Key.accessToken)
        static var accessToken: String?
        
        // MARK: - Methods
        
        static func clear() {
            Session.accessToken = nil
        }
    }
}
