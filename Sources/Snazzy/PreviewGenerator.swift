//
//  PreviewGenerator.swift
//  Snazzy
//
//  Created by AJ Bartocci on 2/24/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

#if DEBUG

import UIKit

struct PreviewGenerator<T: Themeable> {
    
    private let theme: T
    init(theme: T) {
        self.theme = theme
    }
    
    func generatedPreviewViewController() -> UIViewController {

        let compStyles = generateComponentStyles(theme)
        let typeStyles = generateTypeStyles(theme)
        let colors = generateColors(theme)
        let fonts = generateFonts(theme)
        
        let vc = PreviewViewController()
        vc.dataSource = PreviewViewControllerDataSource(
            styles: compStyles,
            colors: colors,
            typeStyles: typeStyles,
            fonts: fonts
        )
        return vc
    }
    
    func generateComponentStyles(_ theme: T) -> [DebugStyle] {
        let compMirror = Mirror(reflecting: theme.componentStyle)
        return compMirror.children.compactMap { (child) -> DebugStyle? in
            if let style = child.value as? DebugComponentStyle {
                let name = String(describing: type(of: style.self))
                return DebugStyle(name: name, styleComponent: style)
            } else {
                return nil
            }
        }
    }
    
    func generateTypeStyles(_ theme: T) -> [TypeStyleable] {
        let typeStyleMirror = Mirror(reflecting: theme.typeStyle)
        return typeStyleMirror.children.compactMap({ $0.value as? TypeStyleable })
    }
    
    func generateColors(_ theme: T) -> [Colorizable] {
        let colorMirror = Mirror(reflecting: theme.color)
        return colorMirror.children.compactMap({ $0.value as? Colorizable })
    }
    
    func generateFonts(_ theme: T) -> [UIFont] {
        let fontMirror = Mirror(reflecting: theme.font)
        return fontMirror.children.compactMap({ $0.value as? UIFont })
    }
}

#endif
