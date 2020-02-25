//
//  ViewController.swift
//  BasicSnazzyExample
//
//  Created by AJ Bartocci on 2/24/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    @IBOutlet private weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()
    }

    private func styleUI() {
        let componentStyles = Theme.current.componentStyle
        componentStyles.header.style(titleLabel)
        componentStyles.body.style(detailLabel)
        componentStyles.actionButton.style(button)
    }

    @IBAction
    private func showPreview() {
        let preview = Theme.generatedPreviewViewController()
        self.navigationController?.pushViewController(preview, animated: true)
    }
}

