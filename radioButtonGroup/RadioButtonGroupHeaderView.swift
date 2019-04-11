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
    }
    
    func setTitle(title: String) {
        self.title.text = title
    }
    
}
