//
//  ExtensionArray.swift
//  radioButtonGroup
//
//  Created by NHNEnt on 11/04/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation

extension Array {
    func splitBy(subSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: subSize).map { startIndex in
            let endIndex = self.index(startIndex, offsetBy: subSize, limitedBy: self.count) ?? self.count
            return Array(self[startIndex ..< endIndex])
        }
    }
}
