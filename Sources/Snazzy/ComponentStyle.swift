//
//  ComponentStyle.swift
//  Snazzy
//
//  Created by AJ Bartocci on 2/18/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

import UIKit

public protocol ComponentStyle: DebugComponentStyle {
    associatedtype T: UIView
    
    func style(_ element: T)
}
