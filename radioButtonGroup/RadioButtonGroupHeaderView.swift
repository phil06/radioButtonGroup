//
//  ButtonGroupHeaderView.swift
//  radioButtonGroup
//
//  Created by NHNEnt on 01/04/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation

class RadioButtonGroupHeaderView: UIView {
    
    var title: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layout()
    }
    
    convenience init(frame: CGRect, title: NSAttributedString) {
        self.init(frame: frame)
        self.title.attributedText = title
    }
    
    func layout() {
        title = UILabel(frame: self.bounds)
        addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        let viewsDictionary:[String : Any] = ["title":title]
        let stackView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[title]-0-|",
                                                         options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                         metrics: nil,
                                                         views: viewsDictionary)
        let stackView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[title(height)]-0-|",
                                                         options: NSLayoutConstraint.FormatOptions(rawValue:0),
                                                         metrics: ["height": self.bounds.height],
                                                         views: viewsDictionary)
        NSLayoutConstraint.activate(stackView_H + stackView_V)
    }
    
    func setTitle(title: String) {
        self.title.text = title
    }
    
}
