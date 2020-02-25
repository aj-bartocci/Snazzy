//
//  PreviewViewController.swift
//  Snazzy
//
//  Created by AJ Bartocci on 2/19/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

#if DEBUG

import UIKit

class PreviewViewController: UIViewController {
    
    var dataSource = PreviewViewControllerDataSource(
        styles: [],
        colors: [],
        typeStyles: [],
        fonts: []
    ) {
        didSet {
            self.loadViewIfNeeded()
            tableView.reloadData()
        }
    }
    let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let reuseId = "reuseId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        dataSource.register(tableView: tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension PreviewViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource.titleForSection(section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.itemCountForSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dataSource.configureCell(at: indexPath, in: tableView)
        return cell
    }
}

extension PreviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section = dataSource.sections[indexPath.section]
        if let styles = section as? [DebugStyle] {
            let style = styles[indexPath.row]
            showComponentDetail(style: style)
        } else if let styles = section as? [TypeStyleable] {
            let style = styles[indexPath.row]
            showTypeStyleDetail(style: style)
        }
    }
    
    func showTypeStyleDetail(style: TypeStyleable) {
        let vc = UIViewController()
        let bgColor: UIColor
        if #available(iOS 13, *) {
            bgColor = .systemBackground
        } else {
            bgColor = .white
        }
        vc.view.backgroundColor = bgColor
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        let nameLabel = UILabel()
        nameLabel.text = style.name
        nameLabel.font = style.font
        stack.addArrangedSubview(nameLabel)
        let fontLabel = UILabel()
        fontLabel.text = "\(style.font.fontName) - \(style.font.pointSize)pt"
        stack.addArrangedSubview(fontLabel)
        vc.view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        let top: NSLayoutConstraint
        if #available(iOS 11.0, *) {
            top = stack.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor, constant: 20)
        } else {
            top = stack.topAnchor.constraint(equalTo: vc.topLayoutGuide.bottomAnchor, constant: 20)
        }
        let center = stack.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor)
        let constraints = [top, center]
        constraints.forEach({ $0.isActive = true })
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showComponentDetail(style: DebugStyle) {
        let component = style.styleComponent.debugView()
        let vc = UIViewController()
        let bgColor: UIColor
        if #available(iOS 13, *) {
            bgColor = .systemBackground
        } else {
            bgColor = .white
        }
        vc.view.backgroundColor = bgColor
        vc.view.addSubview(component)
        let constraints: [NSLayoutConstraint]
        if component.constraints.count > 0 {
            // rely on constraints
            component.translatesAutoresizingMaskIntoConstraints = false
            constraints = component.constraints
        } else {
            // no info so constrain the top
            let top: NSLayoutConstraint
            if #available(iOS 11.0, *) {
                top = component.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor, constant: 20)
            } else {
                top = component.topAnchor.constraint(equalTo: vc.topLayoutGuide.bottomAnchor, constant: 20)
            }
            let width = component.widthAnchor.constraint(equalToConstant: component.frame.width)
            let height = component.heightAnchor.constraint(equalToConstant: component.frame.height)
            let centerX = component.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor)
            component.translatesAutoresizingMaskIntoConstraints = false
            constraints = [top, width, height, centerX]
        }
        constraints.forEach({ $0.isActive = true })
        vc.title = style.name
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

#endif
