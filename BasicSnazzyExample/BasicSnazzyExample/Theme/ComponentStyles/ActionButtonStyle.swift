//
//  ActionButtonStyle.swift
//  BasicSnazzyExample
//
//  Created by AJ Bartocci on 2/24/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

import UIKit
import Snazzy

struct ActionButtonStyle: ComponentStyle {
    
    public func style(_ element: UIButton) {
        element.layer.cornerRadius = 10
        let colors = Theme.current.color
        element.backgroundColor = colors.actionBg.value
        element.setTitleColor(.white, for: .normal)
        element.setTitleColor(.lightGray, for: .highlighted)
        element.titleLabel?.font = Theme.current.typeStyle.actionButton.font
    }
    
    #if DEBUG
    public func debugView() -> UIView {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 60))
        button.setTitle("Some Text", for: .normal)
        style(button)
        return button
    }
    #endif
}
