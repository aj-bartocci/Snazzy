//
//  PreviewTheme.swift
//  Snazzy
//
//  Created by AJ Bartocci on 2/19/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

/*
 
 Internal theme used for the preview generator.
 
 ~~ Theme-ception ~~
 
 */

#if DEBUG

import UIKit

struct RoundedStyle: ComponentStyle {
    
    var radius: CGFloat
    init(radius: CGFloat = 10) {
        self.radius = radius
    }
    
    func style(_ element: UIView) {
        element.layer.cornerRadius = radius
    }
    
    #if DEBUG
    func debugView() -> UIView {
        return UIView()
    }
    #endif
}

struct BorderStyle: ComponentStyle {
    var width: CGFloat
    var color: UIColor?
    
    init(
        width: CGFloat,
        color: UIColor?
    ) {
        self.width = width
        self.color = color
    }
    
    func style(_ element: UIView) {
        element.layer.borderColor = color?.cgColor
        element.layer.borderWidth = width
    }
    
    #if DEBUG
    func debugView() -> UIView {
        return UIView()
    }
    #endif
}


struct _Theme: Themeable {
    struct Style {
        let rounded = RoundedStyle()
        let bordered = BorderStyle(width: 2, color: .lightGray)
    }
    
    struct Color { }
    
    let componentStyle = Style()
    let color = Color()
    let font = EmptyThemeContainer()
    let typeStyle = EmptyThemeContainer()
}

let InternalTheme = Theme(_Theme())

#endif
