//
//  ColorTableViewCell.swift
//  Snazzy
//
//  Created by AJ Bartocci on 2/19/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

#if DEBUG

import UIKit

//    can't currently bundle resources with SPM so need to just
//    create the cell programmatically instead of using a nib

class ColorTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let colorView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.addSubview(colorView)
        self.addSubview(titleLabel)
        colorView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints.append(colorView.widthAnchor.constraint(equalToConstant: 50))
        constraints.append(colorView.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(colorView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 10))
        constraints.append(self.bottomAnchor.constraint(greaterThanOrEqualTo: colorView.bottomAnchor, constant: 10))
        constraints.append(colorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10))
        constraints.append(colorView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor))
        constraints.append(titleLabel.leftAnchor.constraint(equalTo: colorView.rightAnchor, constant: 10))
        constraints.append(titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10))
        constraints.append(titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5))
        constraints.append(titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5))
        NSLayoutConstraint.activate(constraints)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        // ignore highlights
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        // ignore selections
    }
    
}

#endif
