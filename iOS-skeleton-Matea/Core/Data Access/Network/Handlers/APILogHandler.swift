//
//  APILogHandler.swift
//  Core
//
//  Created by Matea Andrei on 8/18/20.
//  Copyright © 2020 Matea Andrei. All rights reserved.
//

import RestBird

struct APILogHandler: PostMiddleware {

    private let jsonDecoder: JSONDecoder

    init() {
        jsonDecoder = JSONDecoder()
    }

    func didPerform(_ request: URLRequest, response: URLResponse, data: Data?) throws {
        guard let response = response as? HTTPURLResponse else { return }
        guard let url = request.url?.absoluteString else { return }

        guard let data = data else { return }
        print("\(request.httpMethod!) \(url) code: \(response.statusCode)")

        if let header = request.allHTTPHeaderFields {
            print(header)
        }

        if let body = request.httpBody {
            print("HTTP body: \(String(data: body, encoding: .utf8)!)")
        }

        print("Response: \(data.prettyPrintedJSONString)")

        print("-----------------------------")
    }
}

private extension Data {
    var prettyPrintedJSONString: NSString { // NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: [.fragmentsAllowed]),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.fragmentsAllowed, .prettyPrinted]),
            let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return "" }

        return prettyPrintedString
    }
}
