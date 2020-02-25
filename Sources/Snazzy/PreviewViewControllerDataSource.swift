//
//  PreviewViewControllerDataSource.swift
//  Snazzy
//
//  Created by AJ Bartocci on 2/19/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

#if DEBUG

import UIKit

struct PreviewViewControllerDataSource {
    let styles: [DebugStyle]
    let colors: [Colorizable]
    let typeStyles: [TypeStyleable]
    let fonts: [UIFont]
    
    private let plainReuseId = "reuseId"
    private let colorReuseId = "colorReuseId"
    
    var sections: [[Any]] {
        return [styles, typeStyles, colors, fonts]
    }
    
    var sectionCount: Int {
        return sections.count
    }
    
    func itemCountForSection(_ section: Int) -> Int {
        return sections[section].count
    }
    
    func titleForSection(_ section: Int) -> String? {
        let section = sections[section]
        if section is [DebugStyle] {
            return "Component Styles"
        } else if section is [Colorizable] {
            return "Colors"
        } else if section is [TypeStyleable] {
            return "Type Styles"
        } else if section is [UIFont] {
            return "Fonts"
        } else {
            return nil
        }
    }
    
    func configureCell(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        let section = sections[indexPath.section]
        let finalCell: UITableViewCell
        if let styles = section as? [DebugStyle] {
            let cell = tableView.dequeueReusableCell(withIdentifier: plainReuseId, for: indexPath)
            let style = styles[indexPath.row]
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
            cell.textLabel?.text = style.name
            cell.accessoryType = .disclosureIndicator
            finalCell = cell
        } else if let colors = section as? [Colorizable] {
            let cell = tableView.dequeueReusableCell(withIdentifier: colorReuseId, for: indexPath)
            let colorCell = cell as! ColorTableViewCell
            let color = colors[indexPath.row]
            colorCell.titleLabel.text = color.name
            colorCell.colorView.backgroundColor = color.value
            let styles = InternalTheme.current.componentStyle
            styles.bordered.style(colorCell.colorView)
            styles.rounded.style(colorCell.colorView)
            colorCell.accessoryType = .none
            finalCell = colorCell
        } else if let styles = section as? [TypeStyleable] {
            let cell = tableView.dequeueReusableCell(withIdentifier: plainReuseId, for: indexPath)
            let style = styles[indexPath.row]
            cell.textLabel?.font = style.font
            cell.textLabel?.text = style.name
            cell.accessoryType = .disclosureIndicator
            finalCell = cell
        } else if let fonts = section as? [UIFont] {
            let cell = tableView.dequeueReusableCell(withIdentifier: plainReuseId, for: indexPath)
            let font = fonts[indexPath.row]
            cell.textLabel?.font = font.withSize(18)
            cell.textLabel?.text = font.fontName
            cell.accessoryType = .none
            finalCell = cell
        } else {
            fatalError("IndexPath out of range")
        }
        return finalCell
    }
    
    func register(tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: plainReuseId)
        tableView.register(ColorTableViewCell.self, forCellReuseIdentifier: colorReuseId)
    }
}

#endif
