//
//  ThemeColor.swift
//  Snazzy
//
//  Created by AJ Bartocci on 2/19/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

import UIKit

public protocol Colorizable {
    var value: UIColor { get }
    #if DEBUG
    var name: String { get }
    #endif
}

// TODO: possible refactor to only use UIColor properties
// similar to how the fonts are done. Colorizable is only
// really handy for dynamic feature flag checks etc, but
// not sure if that should be supported 

public struct ThemeColor: Colorizable {
    public let value: UIColor

    #if DEBUG
    public let name: String
    #endif
    
    public init(_ value: UIColor, name: String) {
        self.value = value
        #if DEBUG
        self.name = name
        #endif
    }
}

public struct DynamicThemeColor: Colorizable {
    
    private let color: () -> UIColor
    public var value: UIColor {
        return color()
    }

    #if DEBUG
    public let name: String
    #endif
    
    public init(
        name: String,
        color: @escaping () -> UIColor
    ) {
        self.color = color
        #if DEBUG
        self.name = name
        #endif
    }
    
}
