//
//  Theme.swift
//  BasicSnazzyExample
//
//  Created by AJ Bartocci on 2/24/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

import Snazzy

struct AppTheme: Themeable {
    let componentStyle = ComponentStyles()
    let typeStyle = TypeStyles()
    let color = Colors()
    let font = Fonts()
}

let Theme = Snazzy.Theme(AppTheme())
