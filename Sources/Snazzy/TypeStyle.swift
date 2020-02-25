//
//  TypeStyle.swift
//  Snazzy
//
//  Created by AJ Bartocci on 2/20/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

import UIKit

public protocol TypeStyleable {
    var font: UIFont { get }
    #if DEBUG
    var name: String { get }
    #endif
}

public struct TypeStyle: TypeStyleable {
    
    private let _font: () -> UIFont
    public var font: UIFont {
        return _font()
    }

    #if DEBUG
    public let name: String
    #endif
    
    public init(
        name: String,
        font: @escaping () -> UIFont
    ) {
        self._font = font
        #if DEBUG
        self.name = name
        #endif
    }
}
