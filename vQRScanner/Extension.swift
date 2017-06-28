//
//  Extension.swift
//  vQRScanner
//
//  Created by DatTran on 5/16/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addConstrainsWithFormat(format: String, views: UIView...) {
        
        var viewDictionary = [String: UIView]()
        
        for (index, view) in views.enumerate() {
            
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
            
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
        
    }
 
    
    
}