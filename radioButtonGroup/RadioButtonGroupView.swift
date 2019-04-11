//
//  ButtonGroupView.swift
//  radioButtonGroup
//
//  Created by NHNEnt on 26/03/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation

public class RadioButtonGroupView: RadioButtonGroupParentView {
    
    private static let screenWidth = UIScreen.main.bounds.size.width
    
    private var stackView: UIStackView!
    private var stackSubViews: [UIView]!
    private var selectedItemRow: Int!
    private var selectedItemCol: Int!
    
    public weak var delegate: RadioButtonDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func bindModel(data: [RadioButtonGroupItemModel]) {
        self.stackSubViews = constructSubViews(data: data)
        
        initLayout()
        layoutViews()
        
        layoutIfNeeded()
    }
    
    private func constructSubViews(data: [RadioButtonGroupItemModel]) -> [UIView] {
        
        var views:[UIView] = []
        
        for row in data {
            
            if useSectionHeaderTitle ?? false {
                views.append(RadioButtonGroupHeaderView(frame: CGRect(x: 0, y: 0, width: RadioButtonGroupView.screenWidth, height: headerHeight),
                                                        title: NSMutableAttributedString(string: row.name, attributes: [NSAttributedString.Key.font: font,
                                                                                                                        NSAttributedString.Key.foregroundColor: foreGroundColor])))
                
                let chunks = row.items.splitBy(subSize: self.itemPerRow)
                
                for col in chunks {
                    let subView = RadioButtonGroupSubView(frame: CGRect.zero, prop: self, data: col)
                    subView.delegate = self
                    subView.currentIdx = views.count
                    views.append(subView)
                }
            }
            
            
        }
        
        return views
    }
    
    private func initLayout() {
        itemInsets = itemInsets ?? UIEdgeInsets.zero
    }

    private func layoutViews() {
        guard buttonImageNORMAL != nil, buttonImageSELECTED != nil else {
            debugPrint("필수 항목 누락")
            return
        }
        
        stackView = UIStackView(arrangedSubviews: stackSubViews)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        addSubview(stackView)
        
        let viewsDictionary:[String : Any] = ["stackView":stackView]
        let stackView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[stackView]-0-|",
                                                         options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                         metrics: nil,
                                                         views: viewsDictionary)
        let stackView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[stackView]-0-|",
                                                         options: NSLayoutConstraint.FormatOptions(rawValue:0),
                                                         metrics: nil,
                                                         views: viewsDictionary)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(stackView_H + stackView_V)
    }

    public func getSelectedItem() -> String? {
        guard selectedItemRow != nil, selectedItemCol != nil else {
            return nil
        }
        
        let sub = self.stackView.arrangedSubviews[selectedItemRow] as! RadioButtonGroupSubView
        if let id = sub.getSelectedView(idx: selectedItemCol) {
            return id
        }
        return nil
    }

}

extension RadioButtonGroupView: RadioButtonDelegate {
    public func radioButtonSelected(currentIdx: Int, colIdx: Int) {
        //기존에 선택된걸 해제
        if let row = selectedItemRow, let col = selectedItemCol {
            let sub = self.stackView.arrangedSubviews[row] as! RadioButtonGroupSubView
            sub.deselectSubViews(idx: col)
        }

        selectedItemCol = colIdx
        selectedItemRow = currentIdx
        
        if let id = getSelectedItem() {
            delegate?.radioButtonSelected?(itemId: id)
        }
    }

    
    
}
