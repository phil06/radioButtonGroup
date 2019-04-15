//
//  RadioButtonDelegate.swift
//  radioButtonGroup
//
//  Created by NHNEnt on 04/04/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation

@objc public protocol RadioButtonDelegate: class {
    @objc optional func radioButtonSelected(itemId: String)
    @objc optional func radioButtonSelected(currentIdx: Int, colIdx: Int)
    @objc optional func radioButtonSelected(currentIdx: Int, sectionIdx: Int, colIdx: Int)
}
