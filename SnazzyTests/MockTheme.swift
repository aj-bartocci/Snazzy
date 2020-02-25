//
//  MockTheme.swift
//  SnazzyTests
//
//  Created by AJ Bartocci on 2/24/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

import UIKit
@testable import Snazzy

struct Fonts {
    let fontOne = UIFont.systemFont(ofSize: 12)
    let fontTwo = UIFont.boldSystemFont(ofSize: 12)
}

struct Colors {
    let colorOne = ThemeColor(.orange, name: "Orange")
    let colorTwo = ThemeColor(.blue, name: "Blue")
}

struct CompStyles {
    struct StyleOne: ComponentStyle {
        func style(_ element: UILabel) { }
        func debugView() -> UIView {
            return UIView()
        }
    }
    struct StyleTwo: ComponentStyle {
        func style(_ element: UIView) { }
        func debugView() -> UIView {
            return UIView()
        }
    }
    let styleOne = StyleOne()
    let styleTwo = StyleTwo()
}

struct TypeStyles {
    let styleOne = TypeStyle(name: "Style One", font: {
        return Fonts().fontOne.withSize(14)
    })
    let styleTwo = TypeStyle(name: "Style Two", font: {
        return Fonts().fontTwo.withSize(30)
    })
}

struct MockTheme: Themeable {
    let componentStyle = CompStyles()
    let typeStyle = TypeStyles()
    let color = Colors()
    let font = Fonts()
}
