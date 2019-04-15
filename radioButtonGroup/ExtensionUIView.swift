//
//  ExtensionUIView.swift
//  radioButtonGroup
//
//  Created by NHNEnt on 12/04/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation

extension UIView {
    func addBorder(arr_edge: [UIRectEdge], color: UIColor, thickness: CGFloat) {
        for edge in arr_edge {
            
            let border = UIView()
            border.backgroundColor = color
            addSubview(border)
            border.translatesAutoresizingMaskIntoConstraints = false
            
            switch edge {
            case UIRectEdge.top:
                border.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                border.heightAnchor.constraint(equalToConstant: thickness).isActive = true
                border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                border.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                break
            case UIRectEdge.bottom:
                border.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -thickness).isActive = true
                border.heightAnchor.constraint(equalToConstant: thickness).isActive = true
                border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                border.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                break
            case UIRectEdge.left:
                border.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                border.leftAnchor.constraint(equalTo: self.rightAnchor, constant: -thickness).isActive = true
                border.widthAnchor.constraint(equalToConstant: thickness).isActive = true
                break
            case UIRectEdge.right:
                border.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                border.widthAnchor.constraint(equalToConstant: thickness).isActive = true
                break
            default:
                break
            }
        }
    }
}
