//
//  HeaderLabelStyle.swift
//  BasicSnazzyExample
//
//  Created by AJ Bartocci on 2/24/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

import UIKit
import Snazzy

struct HeaderLabelStyle: ComponentStyle {
    
    public func style(_ element: UILabel) {
        let colors = Theme.current.color
        element.textAlignment = .center
        element.textColor = colors.mainText.value
        element.font = Theme.current.typeStyle.header.font
    }
    
    #if DEBUG
    public func debugView() -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        label.text = "Some Header Text"
        label.numberOfLines = 0
        style(label)
        return label
    }
    #endif
}
