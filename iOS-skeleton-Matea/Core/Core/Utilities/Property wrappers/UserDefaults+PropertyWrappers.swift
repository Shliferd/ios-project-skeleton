//
//  UserDefaults+PropertyWrappers.swift
//  Core
//
//  Created by Matea Andrei on 8/16/20.
//  Copyright © 2020 Matea Andrei. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UserDefault<T> {
    
    // MARK: - Public properties
    
    let key: String
    let defaultValue: T
    
    public var wrappedValue: T {
        get { return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
    
    // MARK: - Init
    
    init(_ key: String, _ defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

@propertyWrapper
public struct UserDefaultCodable<T: Codable> {
    
    // MARK: - Public properties
    
    let key: String
    
    public var wrappedValue: T? {
        get {
            guard let data = UserDefaults.standard.value(forKey: key) as? Data else { return nil }
            return try? JSONDecoder().decode(T.self, from: data)
        }
        
        set {
            UserDefaults.standard.setValue(try? JSONEncoder().encode(newValue), forKey: key)
        }
    }
    
    // MARK: - Init
    
    init(_ key: String) {
        self.key = key
    }
}
