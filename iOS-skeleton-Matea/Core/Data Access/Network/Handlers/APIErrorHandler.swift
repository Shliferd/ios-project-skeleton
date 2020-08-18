//
//  APIErrorHandler.swift
//  Core
//
//  Created by Matea Andrei on 8/18/20.
//  Copyright © 2020 Matea Andrei. All rights reserved.
//

import RestBird

struct APIErrorHandler: PostMiddleware {
    
    // MARK: - Private properties
    
    private let jsonDecoder: JSONDecoder = JSONDecoder()
    
    // MARK: - Public methods
    
    func didPerform(_ request: URLRequest, response: URLResponse, data: Data?) throws {
        guard let data = data else { return }
        guard let response = response as? HTTPURLResponse else { return }
        guard response.statusCode >= 300 else { return }
        guard let errorResponse = try? jsonDecoder.decode(APIErrorResponse.self, from: data) else { return }
        
        switch response.statusCode {
        case 401:
            NotificationCenter.default.post(name: .unauthorizedSession, object: nil, userInfo: nil)
        case 404:
            if errorResponse.message == "user was deleted" {
                NotificationCenter.default.post(name: .userAccountDeleted, object: nil, userInfo: nil)
            }
        default:
            break
        }
        throw errorResponse
    }
}
