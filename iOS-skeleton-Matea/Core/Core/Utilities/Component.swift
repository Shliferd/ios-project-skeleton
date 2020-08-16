//
//  Component.swift
//  Core
//
//  Created by Matea Andrei on 8/16/20.
//  Copyright © 2020 Matea Andrei. All rights reserved.
//

import Foundation

open class Component<Parent> {
    
    // MARK: - Public properties
    
    public let parent: Parent
    
    // MARK: - Init
    
    public init(parent: Parent) {
        self.parent = parent
    }
}
