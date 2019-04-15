//
//  RadioButtonGroupParentView.swift
//  radioButtonGroup
//
//  Created by NHNEnt on 11/04/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation

public class RadioButtonGroupParentView: UIView {
    
    /* 아이템 그룹 라벨 노출 여부 */
    public var useSectionHeaderTitle: Bool!
    /* 아이템 그룹 라벨 텍스트 타입 */
    public var headerFont: UIFont!
    /* 아이템 그룹 라벨 텍스트 색상 */
    public var headerForeGroundColor: UIColor!
    /* 아이템 그룹 라벨 영역 inset */
    public var headerInset: UIEdgeInsets!
    
    /* 라디오버튼 이미지 (NORMAL) */
    public var buttonImageNORMAL: UIImage!
    /* 라디오버튼 이미지 (SELECTED) */
    public var buttonImageSELECTED: UIImage!
    
    /* 라벨 유형 텍스트 타입 */
    public var font: UIFont!
    /* 라벨 유형 텍스트 색상 */
    public var foreGroundColor: UIColor!
    
    /* 아이템 inset */
    public var itemInsets: UIEdgeInsets!
    /* 한 행에 표현할 아이템 갯수 */
    public var itemPerRow: Int!
    
    /* 아이템 그룹 영역 inset */
    public var sectionInset: UIEdgeInsets!
    /* 아이템 그룹 영역 경계선 설정 여부 */
    public var sectionBorder: [UIRectEdge]!
    /* 아이템 그룹 영역 경계선 두께 */
    public var sectionBorderWidth: CGFloat!
    /* 아이템 그룹 영역 경계선 색상 */
    public var sectionBorderColor: UIColor!
    
}
