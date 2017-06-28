//
//  ViewController.swift
//  vQRScanner
//
//  Created by DatTran on 5/16/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    struct PassData {
        
        static var Mode: String = ""
    
    }
    
    let hospitalBtn: UIButton = {
       
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor.orangeColor()
        button.setTitle("Bệnh viện", forState: .Normal) // Khác
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.titleLabel?.font = UIFont(name: "Courier-Oblique", size: 22)
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = true
        
        return button
    
    }()
    
    let otherBtn: UIButton = {
    
        let button = UIButton(type: .System)
        button.setTitle("Khác", forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.backgroundColor = UIColor.orangeColor()
        button.titleLabel?.font = UIFont(name: "Courier-Oblique", size: 22)
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = true
        
        return button
    
    }()
    
    let logoImg: UIImageView = {
    
        let img = UIImageView(image: UIImage(named: "ic_logo"))
        img.contentMode = .ScaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    
    
    }()
    
    func setupViews() {
        
        let bgImg = UIImageView(frame: UIScreen.mainScreen().bounds)
        bgImg.image = UIImage(named: "ic_background")
        bgImg.contentMode = .ScaleAspectFill
        view.insertSubview(bgImg, atIndex: 0)

        view.addSubview(logoImg)
        view.addSubview(hospitalBtn)
        view.addSubview(otherBtn)
        
        view.addConstrainsWithFormat("H:|-10-[v0]-10-|", views: hospitalBtn)
        view.addConstrainsWithFormat("H:|-10-[v0]-10-|", views: otherBtn)
        view.addConstrainsWithFormat("H:|-30-[v0]-30-|", views: logoImg)
        view.addConstrainsWithFormat("V:|-\(UIScreen.mainScreen().bounds.height/2)-[v0(45)]-10-[v1(45)]", views: hospitalBtn, otherBtn)
        view.addConstrainsWithFormat("V:[v0(45)]", views: logoImg)
        
        view.addConstraint(NSLayoutConstraint(item: logoImg, attribute: .Bottom, relatedBy: .Equal, toItem: hospitalBtn, attribute: .Top, multiplier: 1, constant: -UIScreen.mainScreen().bounds.height*1.0/3))
        
        hospitalBtn.addTarget(HomeController().self, action: #selector(handleHospital), forControlEvents: .TouchUpInside)

        otherBtn.addTarget(HomeController().self, action: #selector(handleOther), forControlEvents: .TouchUpInside)

        
    }
    
    // HANDLE
    func handleHospital(sender: UIButton) {
        
        HomeController.PassData.Mode = "HOSPITAL"
        self.presentViewController(UINavigationController(rootViewController: QRScanner()), animated: true, completion: nil)
        
    }
    
    func handleOther(sender: UIButton) {
        
        HomeController.PassData.Mode = "OTHER"
        self.presentViewController(UINavigationController(rootViewController: QRScanner()), animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let data = "ANSV;100010;TD"
        
        if ((data.rangeOfString(";")) != nil && data.componentsSeparatedByString(";")[0] == "ANSV") {
            
            var splitStr = data.componentsSeparatedByString(";")

            print (splitStr[1])
            
        }
//        print (data.componentsSeparatedByString(";")[0])
        setupViews()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

