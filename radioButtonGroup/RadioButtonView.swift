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
    private var gesture: UITapGestureRecognizer!
    
    public weak var delegate: RadioButtonDelegate?
    
    var contentView: UIView!
    var labelId: String!
    
    public override init(frame: CGRect) {
        // For use in code
        super.init(frame: frame)
        setUpView()
        setupGesture()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        // For use in Interface Builder
        super.init(coder: aDecoder)
        setUpView()
        setupGesture()
    }
    
    private func setupGesture() {
        radioButton.isUserInteractionEnabled = false
        buttonLabel.isUserInteractionEnabled = false
        
        self.gesture = UITapGestureRecognizer(target: self, action: #selector(toggleButton))
        self.gesture.cancelsTouchesInView = true
        self.addGestureRecognizer(self.gesture)
    }
    
    public func removeGesture() {
        
        radioButton.isUserInteractionEnabled = true
        buttonLabel.isUserInteractionEnabled = true

        self.removeGestureRecognizer(self.gesture)
        
        
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
        backgroundColor = UIColor.clear
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
        if self.radioButton.isSelected {
            return
        }
        
        tapView(val: nil)
        delegate?.radioButtonSelected!(itemId: self.labelId)
    }
    
    func tapView(val: Bool?) {
        self.radioButton.isSelected = val ?? !self.radioButton.isSelected
    }

}
