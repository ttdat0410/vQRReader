//
//  HeaderCell.swift
//  vQRScanner
//
//  Created by DatTran on 5/16/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import Foundation
import UIKit

class HeaderCell: UITableViewHeaderFooterView {
    
    let title: UILabel = {
    
        let label = UILabel()
        
        label.text = ""
        label.textColor = UIColor.darkGrayColor()
        label.textAlignment = .Left
        label.font = UIFont.systemFontOfSize(12)
        
        return label
    
    }()

    let line: UIView = {
    
        let v = UIView()
        v.backgroundColor = UIColor.darkGrayColor()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
        
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("wtf?")
    }
    
    func setupViews() {
        
        addSubview(title)
        addSubview(line)
        
        addConstrainsWithFormat("H:|-5-[v0]-5-|", views: title)
        addConstrainsWithFormat("H:|-1-[v0]-1-|", views: line)

        addConstrainsWithFormat("V:|-5-[v0]-5-[v1(0.5)]-1-|", views: title, line)
        
    }
    
}