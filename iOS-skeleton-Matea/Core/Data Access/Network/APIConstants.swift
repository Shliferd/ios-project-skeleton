//
//  APIConstants.swift
//  Core
//
//  Created by Matea Andrei on 8/16/20.
//  Copyright © 2020 Matea Andrei. All rights reserved.
//

import Foundation

enum API {
    
    #if DEBUG
    static let backendURL = ""
    #else
    static let backendURL = ""
    #endif
    
    enum Path {
        
    }
    
    enum Param {
        static let id = "id"
    }
    
    enum Header {
        static let authorization    = "Authorization"
        static let timestamp        = "timestamp"
    }
}
