//
//  NetworkStatusManager.swift
//  Core
//
//  Created by Matea Andrei on 8/18/20.
//  Copyright © 2020 Matea Andrei. All rights reserved.
//

import Foundation
import Reachability
import RxSwift
import RxCocoa

public protocol NetworkStatusManager {
    var isNetworkAvailable: BehaviorRelay<Bool> { get }
}

public protocol NetworkStatusManagerDelegate: class {
    func networkStatusDidChange(on networkStatusManager: NetworkStatusManager)
}

public protocol NetworkStatusProtocol: AnyObject {
    var networkStatusManager: NetworkStatusManager { get }
    var shouldReloadFromOffline: Bool { get set }
    var disposeBag: DisposeBag { get }
    
    func loadDataAfterOffline()
}

public extension NetworkStatusProtocol {
    func handleOfflineState() {
        networkStatusManager.isNetworkAvailable.subscribe { [weak self] value in
            guard let `self` = self else { return }
            if value.element ?? false {
                if self.shouldReloadFromOffline {
                    self.loadDataAfterOffline()
                }
            } else {
                self.shouldReloadFromOffline = true
            }
        }.disposed(by: disposeBag)
    }
}

final class NetworkStatusManagerImpl: NetworkStatusManager {
    
    // MARK: - Private properties
    
    private let reachability: Reachability?
    
    // MARK: - Public properties
    
    var isNetworkAvailable = BehaviorRelay<Bool>(value: true)
    
    // MARK: - Init
    
    init() {
        do {
            reachability = try Reachability()
        } catch {
            fatalError("can not initialize reachability component")
        }
        startMonitoring()
    }
    
    // MARK: - Private methods

    private func startMonitoring() {
        guard let reachability = reachability else { return }
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {}
    }
    
    @objc private func reachabilityChanged(_ notification: Foundation.Notification) {
        guard let reachability = notification.object as? Reachability else { return }
        
        switch reachability.connection {
        case .wifi, .cellular:
            isNetworkAvailable.accept(true)
        case .none, .unavailable:
            isNetworkAvailable.accept(false)
        }
    }
}

