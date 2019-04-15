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
    
    private var selectedSection: Int!
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
        initLayout()
        
        self.stackSubViews = constructSubViews(data: data)
        
        layoutViews()
        
        layoutIfNeeded()
    }
    
    private func constructSubViews(data: [RadioButtonGroupItemModel]) -> [UIView] {
        
        var views:[UIView] = []
        
        for row in data {
            
            if useSectionHeaderTitle ?? false {
                //CGRect(x: 0, y: 0, width: RadioButtonGroupView.screenWidth, height: headerHeight)
                views.append(RadioButtonGroupHeaderView(frame: CGRect.zero,
                                                        title: NSMutableAttributedString(string: row.name, attributes: [NSAttributedString.Key.font: headerFont,
                                                                                                                        NSAttributedString.Key.foregroundColor: headerForeGroundColor]),
                                                        inset: self.headerInset))
            } 
            
            let chunks = row.items.splitBy(subSize: self.itemPerRow)
            
            var sectionGroupViews: [UIView] = []
            
            for item in chunks.enumerated() {
                let subView = RadioButtonGroupSubView(frame: CGRect.zero, prop: self, data: item.element)
                subView.delegate = self
                subView.currentIdx = item.offset
                subView.sectionIdx = views.count
                sectionGroupViews.append(subView)
            }
            
            let stackView = UIStackView(arrangedSubviews: sectionGroupViews)
            stackView.axis = .vertical
            stackView.spacing = 0
            stackView.layoutMargins = sectionInset
            stackView.isLayoutMarginsRelativeArrangement = true
            
            //section border 설정 추가하기
            if sectionBorder.count > 0 {
                stackView.addBorder(arr_edge: sectionBorder, color: sectionBorderColor, thickness: sectionBorderWidth)
            }
            
            views.append(stackView)
        }
        
        return views
    }
    
    private func initLayout() {
        itemInsets = itemInsets ?? UIEdgeInsets.zero
        sectionInset = sectionInset ?? UIEdgeInsets.zero
        sectionBorder = sectionBorder ?? []
        headerInset = headerInset ?? UIEdgeInsets.zero
        backgroundColor = self.backgroundColor ?? UIColor.clear
    }

    private func layoutViews() {
        guard buttonImageNORMAL != nil, buttonImageSELECTED != nil else {
            debugPrint("필수 항목 누락")
            return
        }
        
        stackView = UIStackView(arrangedSubviews: stackSubViews)
        stackView.axis = .vertical
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
        guard selectedItemRow != nil, selectedItemCol != nil, selectedSection != nil else {
            return nil
        }
        
        let stack = self.stackView.arrangedSubviews[selectedSection] as! UIStackView
        let sub = stack.arrangedSubviews[selectedItemRow] as! RadioButtonGroupSubView
        return sub.getSelectedView(idx: selectedItemCol)
    }

}

extension RadioButtonGroupView: RadioButtonDelegate {
    
    public func radioButtonSelected(currentIdx: Int, sectionIdx: Int, colIdx: Int) {
        if let row = selectedItemRow, let col = selectedItemCol, let section = selectedSection {
            let stack = self.stackView.arrangedSubviews[section] as! UIStackView
            let sub = stack.arrangedSubviews[row] as! RadioButtonGroupSubView
            sub.deselectSubViews(idx: col)
        }
        
        selectedItemCol = colIdx
        selectedItemRow = currentIdx
        selectedSection = sectionIdx
        
        if let id = getSelectedItem() {
            delegate?.radioButtonSelected?(itemId: id)
        }
    }
    
}
