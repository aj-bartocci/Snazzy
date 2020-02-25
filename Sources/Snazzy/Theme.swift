//
//  Theme.swift
//  Snazzy
//
//  Created by AJ Bartocci on 2/18/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

import Foundation
import UIKit

// TODO: possible change this to from associated types to pre defined classes,
// then users would subclass the predefined class instead of providing an associated type
// this will make it easier to swap out themes since there is no generic requirements

public protocol Themeable {
    associatedtype ComponentStyleContainer
    associatedtype ColorContainer
    associatedtype FontContainer
    associatedtype TypeStyleContainer
    
    /**
     This property is a container for your component styles. A component style is used to style UI components in specific ways. Properties must conform to **ComponentStyle** in order to be included in the generated preivew. Any other properties that do not conform to **ComponentStyle** will still work as defined, but will not be picked up by the preivew generator.
     */
    var componentStyle: ComponentStyleContainer { get }
    /**
    This property is a container for your type styles. A type style is used to style fonts in specific ways. Properties must conform to **TypeStyleable** in order to be included in the generated preivew. The struct **TypeStyle** has been provided for you to make this easier. Any other properties that do not conform to **TypeStyleable** will still work as defined, but will not be picked up by the preivew generator.
    */
    var typeStyle: TypeStyleContainer { get }
    /**
    This property is a container for your theme colors. Properties must conform to **Colorizable** in order to be included in the generated preivew. The struct **ThemeColor** has been provided for you to make this easier. Any other properties that do not conform to **Colorizable** will still work as defined, but will not be picked up by the preivew generator.
    */
    var color: ColorContainer { get }
    /**
    This property is a container for your theme colors. Properties must of type **UIFont** in order to be included in the generated preivew. Any other properties that are not of type **UIFont** will still work as defined, but will not be picked up by the preivew generator.
    */
    var font: FontContainer { get }
}

struct DebugStyle {
    let name: String
    let styleComponent: DebugComponentStyle
}

public struct Theme<T: Themeable> {
    public var current: T
    
    public init(_ initialTheme: T) {
        self.current = initialTheme
    }
    
    #if DEBUG
    /**
     Generates a preview view controller for your theme. This is only available when running an app in DEBUG. The preview relies on reflection via Swift's Mirror.
     */
    public func generatedPreviewViewController() -> UIViewController {

        let compMirror = Mirror(reflecting: current.componentStyle)
        let styles = compMirror.children.compactMap { (child) -> DebugStyle? in
            if let style = child.value as? DebugComponentStyle {
                let name = String(describing: type(of: style.self))
                return DebugStyle(name: name, styleComponent: style)
            } else {
                return nil
            }
        }
        
        let typeStyleMirror = Mirror(reflecting: current.typeStyle)
        let typeStyles = typeStyleMirror.children.compactMap({ $0.value as? TypeStyleable })
        
        let colorMirror = Mirror(reflecting: current.color)
        let colors = colorMirror.children.compactMap({ $0.value as? Colorizable })
        
        let fontMirror = Mirror(reflecting: current.font)
        let fonts = fontMirror.children.compactMap({ $0.value as? UIFont })
        
        let vc = PreviewViewController()
        vc.dataSource = PreviewViewControllerDataSource(
            styles: styles,
            colors: colors,
            typeStyles: typeStyles,
            fonts: fonts
        )
        return vc
    }
    #endif
}


