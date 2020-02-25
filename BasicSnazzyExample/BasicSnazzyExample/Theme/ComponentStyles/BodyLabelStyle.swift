//
//  BodyLabelStyle.swift
//  BasicSnazzyExample
//
//  Created by AJ Bartocci on 2/24/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

import UIKit
import Snazzy

struct BodyLabelStyle: ComponentStyle {
    
    public func style(_ element: UILabel) {
        let colors = Theme.current.color
        element.textAlignment = .left
        element.textColor = colors.mainText.value
        element.font = Theme.current.typeStyle.body.font
    }
    
    #if DEBUG
    public func debugView() -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        label.text = "Some Body Text"
        label.numberOfLines = 0
        style(label)
        return label
    }
    #endif
}
