//
//  APINoConnectionHandler.swift
//  Core
//
//  Created by Matea Andrei on 8/18/20.
//  Copyright © 2020 Matea Andrei. All rights reserved.
//

import RestBird

struct APINoConnectionHandler: PreMiddleware {
    
    private let networStatusManager: NetworkStatusManager
    
    init(networStatusManager: NetworkStatusManager) {
        self.networStatusManager = networStatusManager
    }
    
    func willPerform(_ request: URLRequest) throws {
        if !networStatusManager.isNetworkAvailable.value {
            throw NetworkError.noConnection
        }
    }
}

public enum NetworkError: Error {
    case noConnection, unknown
}
