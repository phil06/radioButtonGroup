//
//  ItemModelVO.swift
//  radioButtonGroup
//
//  Created by NHNEnt on 26/03/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation

public class RadioButtonGroupItemModel: Codable {
    var name: String
    var items: [RadioButtonItemModel]
    
    public init(name: String, items: [RadioButtonItemModel]) {
        self.name = name
        self.items = items
    }
}

public class RadioButtonItemModel: Codable, Equatable {
    
    public static func == (lhs: RadioButtonItemModel, rhs: RadioButtonItemModel) -> Bool {
        if lhs.id != rhs.id {
            return false
        }
        
        if lhs.name != rhs.name {
            return false
        }
        
        return true
    }
    
    var id: String
    var name: String
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
