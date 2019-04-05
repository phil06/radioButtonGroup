//
//  ButtonGroupHeaderView.swift
//  radioButtonGroup
//
//  Created by NHNEnt on 01/04/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation

class RadioButtonGroupHeaderView: UICollectionReusableView {
    
    var title: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layout()
        //        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        title = UILabel(frame: self.bounds)
        addSubview(title)
    }
    
    func setTitle(title: String) {
        self.title.text = title
    }
    
}
