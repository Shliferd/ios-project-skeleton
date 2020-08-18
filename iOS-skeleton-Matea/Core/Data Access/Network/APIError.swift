//
//  APIError.swift
//  Core
//
//  Created by Matea Andrei on 8/16/20.
//  Copyright © 2020 Matea Andrei. All rights reserved.
//

import Foundation

public struct APIErrorResponse: Error, Decodable {
    public let title: String
    public let body: String
    public let message: String
    public let status: Int
}
