//
//  APIConfiguration.swift
//  Core
//
//  Created by Matea Andrei on 8/16/20.
//  Copyright © 2020 Matea Andrei. All rights reserved.
//

import Foundation
import RxSwift
import RestBird

struct APIConfiguration: NetworkClientConfiguration {
    
    // MARK: - Public properties
    
    let baseUrl: String
    let jsonEncoder: JSONEncoder
    let jsonDecoder: JSONDecoder
    
    // MARK: - Init
    
    init() {
        // URL
        baseUrl = API.backendURL
        
        // DateFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)!
        dateFormatter.locale = Locale(identifier: "en_US")
        
        // Serialization
        jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .formatted(dateFormatter)
        jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
    }
}
