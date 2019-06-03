//
//  RadioButtonGroupSubView.swift
//  radioButtonGroup
//
//  Created by NHNEnt on 11/04/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation

class RadioButtonGroupSubView: RadioButtonGroupParentView {

    private var stackView: UIStackView!
    private var stackSubViews: [UIView]!
    
    weak var delegate: RadioButtonDelegate?
    
    var currentIdx: Int!
    var sectionIdx: Int!
    var defaultOnIdx: Int?
 
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, prop: RadioButtonGroupParentView, data: [RadioButtonItemModel]) {
        self.init(frame: frame)
        self.stackSubViews = []
        
        self.font = prop.font
        self.foreGroundColor = prop.foreGroundColor
        self.buttonImageNORMAL = prop.buttonImageNORMAL
        self.buttonImageSELECTED = prop.buttonImageSELECTED
        self.itemInsets = prop.itemInsets
        self.defaultId = prop.defaultId
        
        self.bindModel(data: data)
    }
    
    private func layoutView() {
        stackView = UIStackView(arrangedSubviews: stackSubViews)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        addSubview(stackView)
  
        let viewsDictionary:[String : Any] = ["stackView":stackView]
        let stackView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[stackView]-0-|",
                                                         metrics: nil,
                                                         views: viewsDictionary)
        let stackView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[stackView]-0-|",
                                                         metrics: nil,
                                                         views: viewsDictionary)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(stackView_H + stackView_V)
    }
    

    
    private func bindModel(data: [RadioButtonItemModel]) {
        for item in data {
            let view = RadioButtonView(frame: CGRect.zero)
            view.setLabel(attr: NSMutableAttributedString(string: item.name,
                                                          attributes: [NSAttributedString.Key.font: self.font,
                                                                       NSAttributedString.Key.foregroundColor: self.foreGroundColor]),
                                                            labelId: item.id)
            view.setImage(normal: self.buttonImageNORMAL, selected: self.buttonImageSELECTED)
            view.setEdgeInsets(inset: self.itemInsets ?? UIEdgeInsets.zero)
            view.delegate = self
            
            
            
            if defaultId == item.id {
                view.tapView(val: true)
                defaultOnIdx = stackSubViews.count
                debugPrint("디폴트 값이 설정되어 있으므로 설정해줌")
            }
            stackSubViews.append(view)
        }
        
        layoutView()
    }
    
    public func deselectSubViews(idx: Int) {
        let button = self.stackView.arrangedSubviews[idx] as! RadioButtonView
        button.tapView(val: false)
    }
    
    public func getSelectedView(idx: Int) -> String? {
        let button = self.stackView.arrangedSubviews[idx] as! RadioButtonView
        return button.labelId
    }
    
    public func setCheckSelectView() {
        if let idx = defaultOnIdx {
            delegate?.radioButtonSelected!(currentIdx: self.currentIdx, sectionIdx: self.sectionIdx, colIdx: idx)
        }
    }
    
}

extension RadioButtonGroupSubView: RadioButtonDelegate {
 
    func radioButtonSelected(itemId: String) {
        for view in self.stackView.arrangedSubviews.enumerated() {
            let button = view.element as! RadioButtonView
            if button.labelId == itemId {
                delegate?.radioButtonSelected!(currentIdx: self.currentIdx, sectionIdx: self.sectionIdx, colIdx: view.offset)
                return
            }
        }
    }
    
    
}
