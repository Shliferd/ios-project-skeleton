//
//  CoreComponent.swift
//  Core
//
//  Created by Matea Andrei on 8/18/20.
//  Copyright © 2020 Matea Andrei. All rights reserved.
//

import Foundation
import RestBird
import Alamofire

public final class CoreComponent {
    
    // MARK: - Private properties
    
    @Lazy(wrappedValue: {
        let configuration = URLSessionConfiguration.af.default
        let adapter = GeneralRequestAdapter()
        let sessionManager = Session(configuration: configuration, interceptor: adapter)
        let session = AlamofireSessionManager(config: APIConfiguration(), session: sessionManager)
        return NetworkClient(session: session)
    }())
    private var networkClient: NetworkClient

    // MARK: - Public propertiess
    
    public lazy var networStatusManager: NetworkStatusManager = NetworkStatusManagerImpl()
    
    // MARK: - Init
    
    public init() {
        networkClient.register(APINoConnectionHandler(networStatusManager: networStatusManager))
        networkClient.register(APILogHandler())
        networkClient.register(APIErrorHandler())
    }
}
