//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by apple on 2024/5/31.
//

import UIKit

extension UIView {
    
    func addSubview(views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
}
