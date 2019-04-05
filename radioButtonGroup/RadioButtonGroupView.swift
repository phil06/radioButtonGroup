//
//  ButtonGroupView.swift
//  radioButtonGroup
//
//  Created by NHNEnt on 26/03/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation

public class RadioButtonGroupView: UIView {
    
    private var dataSource: [RadioButtonGroupItemModel]!
    
    private var collectionView: UICollectionView!
    
    private var selectedItemId: String!
    private var cellItemWidth: CGFloat!
    
    public weak var delegate: RadioButtonDelegate?
    
    /* 아이템 inset */
    public var itemInsets: UIEdgeInsets!
    /* 한 행에 표현할 아이템 갯수 */
    public var itemPerRow: Int!
    
    /* 아이템 그룹 라벨 노출 여부 */
    public var useSectionHeaderTitle: Bool!
    /* 아이템 그룹 라벨 높이 */
    public var headerHeight: CGFloat!
    /* 아이템 그룹 영역 뷰 insets */
    public var sectionInset: UIEdgeInsets!

    /* 라벨 유형 텍스트 타입 */
    public var font: UIFont!
    /* 라벨 유형 텍스트 색상 */
    public var foreGroundColor: UIColor!
    
    /* 라디오버튼 이미지 (NORMAL) */
    public var buttonImageNORMAL: UIImage!
    /* 라디오버튼 이미지 (SELECTED) */
    public var buttonImageSELECTED: UIImage!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }

    public func bindModel(data: [RadioButtonGroupItemModel]) {
        self.dataSource = data
        layoutViews()
    }
    
    private func layoutViews() {
        
        self.backgroundColor = UIColor.clear
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = self.sectionInset ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.register(RadioButtonGroupCell.self, forCellWithReuseIdentifier: "ButtonGroupCell")
        collectionView.register(RadioButtonGroupHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ButtonGroupHeaderView")
        collectionView.backgroundColor = UIColor.clear
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.calculateSetCellWidth()
        
        self.collectionView.reloadData()
//        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    public func getSelectedItem() -> String? {
        if let selected = collectionView.indexPathsForSelectedItems {
            for indexPath in selected {
                let cell = collectionView.cellForItem(at: indexPath) as! RadioButtonGroupCell
                return cell.btn.labelId
                //            debugPrint("선택한 아이템(ID) > \(cell.btn.labelId)")
            }
        }
        return nil
    }
    
    private func calculateSetCellWidth() {
        let frameWidth = self.bounds.width - self.sectionInset.left - self.sectionInset.right
        self.cellItemWidth = frameWidth / CGFloat(self.itemPerRow)
        //(frameWidth - (self.paddingOfItem * CGFloat(self.itemPerRow - 1))) / CGFloat(self.itemPerRow)
    }

}

extension RadioButtonGroupView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSource.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource[section].items.count
    }
    
    
    //cell auto resize 를 이용하여 맞추고.. 셀의 inset 을 받아서 여백을 조정할 수 있게 해보자.
    //흠.. 컬렉션뷰에서 이미 사이즈를 픽싱하고 들어가게 되니까... 오토레이아웃이래봤자 소용이......
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        var frameWidth = self.bounds.width - self.sectionInset.left - self.sectionInset.right
//        var itemWidth = (frameWidth - (paddingOfItem * CGFloat(itemPerRow - 1))) / CGFloat(itemPerRow)
//
//        debugPrint("frameWidth : \(frameWidth), itemWidth : \(itemWidth)")
//
//        var height: CGFloat = 50 //테스트용 임시 사이즈
//
//        return CGSize(width: itemWidth, height: height)
//    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ButtonGroupHeaderView", for: indexPath) as? RadioButtonGroupHeaderView
            // Customize headerView here

            headerView?.title.attributedText = NSMutableAttributedString(string: self.dataSource[indexPath.section].name,
                                                                         attributes: [NSAttributedString.Key.font: self.font,
                                                                                      NSAttributedString.Key.foregroundColor: self.foreGroundColor])
            return headerView!
        }
        return UICollectionReusableView()
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if useSectionHeaderTitle ?? false {
            return CGSize(width: self.bounds.width, height: self.headerHeight)
        }
        return CGSize.zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonGroupCell", for: indexPath) as? RadioButtonGroupCell
        cell?.btn.setLabel(attr: NSMutableAttributedString(string: self.dataSource[indexPath.section].items[indexPath.row].name,
                                                           attributes: [NSAttributedString.Key.font: self.font,
                                                                        NSAttributedString.Key.foregroundColor: self.foreGroundColor]),
                           labelId: self.dataSource[indexPath.section].items[indexPath.row].id)
        cell?.btn.setImage(normal: self.buttonImageNORMAL, selected: self.buttonImageSELECTED)
        cell?.btn.setEdgeInsets(inset: self.itemInsets ?? UIEdgeInsets.zero)
        cell?.adjustWidth = self.cellItemWidth
        return cell!
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! RadioButtonGroupCell

        if self.selectedItemId ?? "" == cell.btn.labelId {
            collectionView.deselectItem(at: indexPath, animated: false)
        } else {
            self.selectedItemId = cell.btn.labelId
            self.delegate?.radioButtonSelected(itemId: self.selectedItemId)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! RadioButtonGroupCell
        cell.btn.tapView(val: false)
    }

    
}
