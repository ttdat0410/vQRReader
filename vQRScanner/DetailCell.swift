//
//  DetailCell.swift
//  vQRScanner
//
//  Created by DatTran on 5/16/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import Foundation
import UIKit

class DetailCell: UITableViewCell {
    
    let informationLabel: UILabel = {

        let label = UILabel()
        label.textAlignment = .Left
        label.text = ""
        label.textColor = UIColor.redColor()
        label.font = UIFont.systemFontOfSize(17)
        
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(informationLabel)
        addConstrainsWithFormat("H:|-10-[v0]-10-|", views: informationLabel)
        addConstrainsWithFormat("V:|-5-[v0(30)]-5-|", views: informationLabel)
        
    }
    
}