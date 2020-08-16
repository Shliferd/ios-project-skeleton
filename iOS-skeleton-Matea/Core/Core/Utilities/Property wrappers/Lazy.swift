//
//  Lazy.swift
//  Core
//
//  Created by Matea Andrei on 8/16/20.
//  Copyright © 2020 Matea Andrei. All rights reserved.
//

import Foundation

@propertyWrapper
public enum Lazy<Value> {
    case uninitialized(() -> Value)
    case initialized(Value)
    
    public init(wrappedValue: @autoclosure @escaping () -> Value) {
        self = .uninitialized(wrappedValue)
    }
    
    public var wrappedValue: Value {
        mutating get {
            switch self {
            case .initialized(let value):
                return value
            case .uninitialized(let initializer):
                let value = initializer()
                self = .initialized(value)
                return value
            }
        }
        
        set {
            self = .initialized(newValue)
        }
    }
}
