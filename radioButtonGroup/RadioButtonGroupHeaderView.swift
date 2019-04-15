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
    var layoutConstraints: [NSLayoutConstraint]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        self.setConstraint(inset: UIEdgeInsets.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layout()
        self.setConstraint(inset: UIEdgeInsets.zero)
    }
    
    convenience init(frame: CGRect, title: NSAttributedString, inset: UIEdgeInsets) {
        self.init(frame: frame)
        self.title.attributedText = title
        self.setConstraint(inset: inset)
    }
    
    func layout() {
        title = UILabel(frame: self.bounds)
        addSubview(title)
    }
    
    private func setConstraint(inset: UIEdgeInsets) {
        title.translatesAutoresizingMaskIntoConstraints = false
        
        if let const = layoutConstraints {
            NSLayoutConstraint.deactivate(const)
        }
        
        let viewsDictionary:[String : Any] = ["title":title]
        let stackView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-left-[title]-right-|",
                                                         metrics: ["left": inset.left, "right": inset.right],
                                                         views: viewsDictionary)
        let stackView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[title]-bottom-|",
                                                         metrics: ["top": inset.top, "bottom": inset.bottom],
                                                         views: viewsDictionary)

        layoutConstraints = stackView_H + stackView_V
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    func setTitle(title: String) {
        self.title.text = title
    }
    
}
