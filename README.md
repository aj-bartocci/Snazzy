#  Snazzy Themes

<img src="https://raw.githubusercontent.com/aj-bartocci/Snazzy/master/Images/snazzy_icon.png" width="160px" height="160px">

#### This is a Work In Progress, not a complete project as of yet. There are still some design decisions that need to be made. This is inspired by [storybook js](https://storybook.js.org)

## Instantly generate documentation for you app theme, and view it in an interactive preview. 

<img src="https://raw.githubusercontent.com/aj-bartocci/Snazzy/master/Images/snazzy.gif" width="300px">

## Goals
* Centralize app styling logic in a theme
* Generate living documentation for a theme 
* Lightweight, as little app bloat as possible 
* Easily prototype your theme components without having to run your full app

## X already exists for theming why should I use Snazzy Themes? 

It's true there are plenty of theming options out there and it's not hard to roll your own, so why is this any different?

With snazzy you get theming support that allows you to style your elements so you can go from unstyled IB view controllers to styled view controllers like: 

![before after example](https://raw.githubusercontent.com/aj-bartocci/Snazzy/master/Images/before_after.png "Before and after styling")

This is nice but not anything crazy. However, Snazzy will automatically generate an interactive preview (gif seen above) from your theme. The preview that Snazzy generates is a tableview showing all the elements that you defined in your theme. You can instantly see the fonts and colors, as well as example elements that are styled by your theme. This is quite powerful because it provides living documentation to your theme. Any changes you make to your theme are picked up in the generated preview via Swift's Mirroring capabilities.

Mirroring may sound scary, but all of the code used to generate your preview is wrapped in the DEBUG macro. This means that none of the purely debug code will ship with your release candidate, it's purely for development purposes. The compiler will even throw an error if you try to generate a preview in a release build.

See the Gotchas section about some of the limitations because of Swift Mirroring. 

## Example App

BasicSnazzyExample is a basic app that demonstrates what Snazzy is intended to do.


## How it works 

You create a theme by create a struct or class that conforms to Themeable. Themeable is a generic protocol with 4 properties that must be defined.

```swift 
public protocol Themeable {
    associatedtype ComponentStyleContainer
    associatedtype ColorContainer
    associatedtype FontContainer
    associatedtype TypeStyleContainer
    
    var componentStyle: ComponentStyleContainer { get }
    var typeStyle: TypeStyleContainer { get }
    var color: ColorContainer { get }
    var font: FontContainer { get }
```

- The font property contains any fonts you want to include in your theme.
- The color property contains any colors you want to include in your theme.
- The typeStyle property contains stylings for your fonts. For example you might define a Header type style that sets a font to a specific size. 
- The componentStyle property contains stylings for your UI elements. Fore exmaple you might have an ActionButton style that styles a button to look a certain way. 

Why have fonts and typeStyles? This is so that you can separate a font from what it is used for. You may want to use a certain font as body text and header text, by using typeStyles you can create a BodyTypeStyle and HeaderTypeStyle. This is so that you can reuse font 'styles' instead of having to specifiy a font size everywhere.

BasicSnazzyExample has a Theme that looks like this: 
```swift
import Snazzy

struct AppTheme: Themeable {
    let componentStyle = ComponentStyles()
    let typeStyle = TypeStyles()
    let color = Colors()
    let font = Fonts()
}

// A global variable for the theme
let Theme = Snazzy.Theme(AppTheme())
```

Snazzy.Theme is a generic struct that holds your theme. It contains one function generatedPreviewViewController which will mirror your theme to generate a preview view controller.

Throughout the app the theme can be referenced by Theme.current

Where ComponentStyles is made up of: 

```swift
// ComponentStyles.swift 

import Snazzy

struct ComponentStyles {
    let actionButton = ActionButtonStyle()
    let header = HeaderLabelStyle()
    let body = BodyLabelStyle()
}

// ActionButtonStyle.swift 
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

// HeaderLabelStyle.swift
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

// BodyLabelStyle.swift 
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

```

TypeStyles is made up of:

```swift
import UIKit
import Snazzy

struct TypeStyles {
    let header = TypeStyle(name: "Header", font: {
        return Theme.current.font.robotoBold.withSize(40)
    })
    let body = TypeStyle(name: "Body", font: {
        return Theme.current.font.playfairRegular.withSize(20)
    })
    let actionButton = TypeStyle(name: "Action Button", font: {
        return Theme.current.font.robotoBold.withSize(20)
    })
}
```

Fonts: 

```swift
import UIKit

struct Fonts {
    let robotoRegular = UIFont(name: "Roboto-Regular", size: 12)!
    let robotoLight = UIFont(name: "Roboto-Light", size: 12)!
    let robotoLightItalic = UIFont(name: "Roboto-LightItalic", size: 12)!
    let robotoBold = UIFont(name: "Roboto-Bold", size: 12)!
    let robotoBoldItalic = UIFont(name: "Roboto-BoldItalic", size: 12)!
    let playfairRegular = UIFont(name: "PlayfairDisplay-Regular", size: 12)!
    let playfairItalic = UIFont(name: "PlayfairDisplay-Italic", size: 12)!
}
```

And Colors: 

```swift
import UIKit
import Snazzy

struct Colors {
    // This color uses a color asset located in Assets.xcassets
    // this color will dynamically change for dark mode (ios 13 only)
    let mainText = ThemeColor(UIColor(named: "MainText")!, name: "Main Text")
    // this is just simple color that won't change 
    let actionBg = ThemeColor(UIColor.orange, name: "Action")
}
```

## Features to add 
* cross platform support for macOS and tvOS 
* nested theme properties (see Gotchas)

## Gotchas: 
    
- Swift Mirroring doesn't support computed properties 
  - This means if you want your theme properties to be generated in the preview, they must not be computed properties
  - If you absolutely must use a computed property your theme will work just fine, the generated preview just wont show that particular property 

- Currently all properties within a container must be at the root level. In this version I don't check for nested properties. This is simply because I haven't had the time to do so yet, the documentation for Swift Mirroring is pretty limited. I plan on adding this in the future if it is possible.

