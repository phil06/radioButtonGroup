//
//  ButtonView.swift
//  radioButtonGroup
//
//  Created by NHNEnt on 22/03/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import UIKit


public class RadioButtonView: UIView {

    @IBOutlet private weak var radioButton: UIButton!
    @IBOutlet private weak var buttonLabel: UILabel!

    private let defaultViewPadding: CGFloat = 5
    private var contentViewConstraints: [NSLayoutConstraint]!
    
    var contentView: UIView!
    var labelId: String!
    
    public override init(frame: CGRect) {
        // For use in code
        super.init(frame: frame)
        setUpView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        // For use in Interface Builder
        super.init(coder: aDecoder)
        setUpView()
    }
    
    private func setUpView() {

        let nibName = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setEdgeInsets(inset: UIEdgeInsets(top: defaultViewPadding, left: defaultViewPadding, bottom: defaultViewPadding, right: defaultViewPadding))
        
        buttonLabel.text = ""
        
        radioButton.isUserInteractionEnabled = false
        buttonLabel.isUserInteractionEnabled = false

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleButton))
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
    }
    
    public func setEdgeInsets(inset: UIEdgeInsets?) {
        
        if let padding = inset {
            
            let metrics = [
                "top": padding.top,
                "left": padding.left,
                "right": padding.right,
                "bottom": padding.bottom
            ]
            
            if let constraints = self.contentViewConstraints {
                NSLayoutConstraint.deactivate(constraints)
            }
            
            contentViewConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[contentView]-bottom-|", metrics: metrics, views: ["contentView": contentView]) +
                                     NSLayoutConstraint.constraints(withVisualFormat: "H:|-left-[contentView]-right-|", metrics: metrics, views: ["contentView": contentView])
            
            NSLayoutConstraint.activate(contentViewConstraints)
            
            updateConstraints()
        }

    }
    
    public func setImage(normal: UIImage, selected: UIImage) {
        self.radioButton.setImage(normal, for: .normal)
        self.radioButton.setImage(selected, for: .selected)

        self.radioButton.sizeToFit()
        let buttonSize = radioButton.frame.size
        self.radioButton.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
        self.radioButton.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
 
        updateConstraints()
    }

    public func setLabel(text: String, labelId: String) {
        self.buttonLabel.text = text
        self.labelId = labelId
    }
    
    public func setLabel(attr: NSAttributedString, labelId: String) {
        self.buttonLabel.attributedText = attr
        self.labelId = labelId
    }
    
    @objc func toggleButton() {
        tapView(val: nil)
    }
    
    func tapView(val: Bool?) {
        self.radioButton.isSelected = val ?? !self.radioButton.isSelected
    }

}
