//
//  KeychainItem+PropertyWrapper.swift
//  Core
//
//  Created by Matea Andrei on 8/16/20.
//  Copyright © 2020 Matea Andrei. All rights reserved.
//

import Foundation
import Security

// MARK: - Private method

private func throwIfNotZero(_ status: OSStatus) throws {
    guard status != 0 else { return }
    throw KeychainError.keychainError(status: status)
}

// MARK: - Keychain

public enum KeychainError: Error {
    case invalidData
    case keychainError(status: OSStatus)
}

@propertyWrapper
final public class KeychainItem {
    
    // MARK: - Private properties
    
    private let account: String
    
    private var baseDictionary: [String: AnyObject] {
        return [
            kSecClass as String: kSecClassGenericPassword,
            kSecClass as String: account as AnyObject
        ]
    }
    
    private var query: [String: AnyObject] {
        return baseDictionary.adding(key: kSecMatchLimit as String, value: kSecMatchLimitOne)
    }
    
    // MARK: - Public properties
    
    public var wrappedValue: String? {
        get { try? read() }
        set {
            if let value = newValue {
                if (try? read()) == nil {
                    try? add(value)
                } else {
                    try? update(value)
                }
            } else {
                try? delete()
            }
        }
    }
    
    // MARK: - Init
    
    public init(account: String) {
        self.account = account
    }
    
    // MARK: - Private methods
    
    private func read() throws -> String? {
        let query = self.query.adding(key: kSecReturnData as String, value: true as AnyObject)
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status != errSecItemNotFound else { return nil }
        try throwIfNotZero(status)
        guard let data = result as? Data, let string = String(data: data, encoding: .utf8) else {
            throw KeychainError.invalidData
        }
        return string
    }
    
    private func delete() throws {
        let status = SecItemDelete(baseDictionary as CFDictionary)
        guard status != errSecItemNotFound else { return }
        try throwIfNotZero(status)
    }
    
    private func add(_ secret: String) throws {
        let dictionary = baseDictionary.adding(key: kSecValueData as String, value: secret.data(using: .utf8) as AnyObject)
        try throwIfNotZero(SecItemAdd(dictionary as CFDictionary, nil))
    }
    
    private func update(_ secret: String) throws {
        let dictionary: [String: AnyObject] = [
            kSecValueData as String: secret.data(using: .utf8) as AnyObject
        ]
        try throwIfNotZero(SecItemUpdate(baseDictionary as CFDictionary, dictionary as CFDictionary))
    }
}

// MARK: - Extensions

extension Dictionary {
    
    func adding(key: Key, value: Value) -> Dictionary {
        var copy = self
        copy[key] = value
        return copy
    }
}
