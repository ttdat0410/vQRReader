
//
//  DetailQRScanned.swift
//  vQRScanner
//
//  Created by DatTran on 5/16/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import Foundation
import UIKit

class Information: UIViewController {
    
    let informationTxt: UITextView = {
        
        let txt = UITextView()
        
        txt.textColor = UIColor.redColor()
        txt.scrollEnabled = true
        txt.font = UIFont(name: "Courier-Oblique", size: 19)
        txt.userInteractionEnabled = false
        
        return txt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Thông tin"
        
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(informationTxt)
        view.addConstrainsWithFormat("H:|-10-[v0]-10-|", views: informationTxt)
        view.addConstrainsWithFormat("V:|-10-[v0(\(view.frame.height-10))]", views: informationTxt)
        
        parseQRData("\(QRScanner.PassData.totalData)")
        
    }
    
    func parseQRData(input: String) {
        
        informationTxt.text = input
            
    }
    
    func changeColorText(txt: String) -> String {
        
        return ""
        
    }

    
    
}

