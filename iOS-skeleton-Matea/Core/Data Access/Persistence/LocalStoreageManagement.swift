//
//  LocalStoreageManagement.swift
//  Core
//
//  Created by Matea Andrei on 8/18/20.
//  Copyright © 2020 Matea Andrei. All rights reserved.
//

import Foundation

private enum Key {
    
}

final public class LocalStoreageManagement {
    
    // MARK: - Public properties

    public static let shared = LocalStoreageManagement()
    
    // MARK: - Private properties
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Private init
    
    private init() {}
}
