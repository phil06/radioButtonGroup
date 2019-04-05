//
//  ButtonGroupCell.swift
//  radioButtonGroup
//
//  Created by NHNEnt on 27/03/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import UIKit

class RadioButtonGroupCell: UICollectionViewCell {
    
    var btn: RadioButtonView!
    var adjustWidth: CGFloat!
    
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
        btn = RadioButtonView(frame: CGRect.zero)
        addSubview(btn)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[btn]-0-|", metrics: nil, views: ["btn": btn]) +
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[btn]-0-|", metrics: nil, views: ["btn": btn]))
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        layoutAttributes.bounds.size.height = size.height
        layoutAttributes.bounds.size.width = adjustWidth
        
        return layoutAttributes
    }

}
