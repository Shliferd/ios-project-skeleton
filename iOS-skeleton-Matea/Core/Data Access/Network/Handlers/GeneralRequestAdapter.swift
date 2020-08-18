//
//  GeneralRequestAdapter.swift
//  Core
//
//  Created by Matea Andrei on 8/16/20.
//  Copyright © 2020 Matea Andrei. All rights reserved.
//

import Alamofire

final class GeneralRequestAdapter: RequestAdapter {

    // MARK: - Public properties

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var newRequest = urlRequest
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let value = formatter.string(from: Date())
        newRequest.setValue(value + "[\(TimeZone.current.identifier)]", forHTTPHeaderField: API.Header.timestamp)
        
        if let accessToken = KeyStore.Session.accessToken {
            newRequest.setValue(accessToken, forHTTPHeaderField: API.Header.authorization)
        }
        
        completion(.success(newRequest))
    }
    
     func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
        //get token
        }
    }
}
