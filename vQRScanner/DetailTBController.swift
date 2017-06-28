//
//  DetailTBController.swift
//  vQRScanner
//
//  Created by DatTran on 5/16/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import Foundation
import UIKit


class DetailTBController: UITableViewController {
    
    let header_cell = "header_cell"
    
    let detail_cell = "detail_cell"
    
    var sections    = ["", "", "", ""]
    
    var items       = [[""], [""], [""], [""],[""],[""],[""]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Thông tin"
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        tableView.allowsSelection = false
        
        tableView.registerClass(HeaderCell.self, forHeaderFooterViewReuseIdentifier: header_cell)
        
        tableView.registerClass(DetailCell.self, forCellReuseIdentifier: detail_cell)
        
        parseQRData("\(QRScanner.PassData.totalData)")
    }
    
    func convertHexToString(hex: String) -> String {
        var hex = hex
        let data = NSMutableData()
        while(hex.characters.count > 0) {
            let c: String = hex.substringToIndex(hex.startIndex.advancedBy(2))
            hex = hex.substringFromIndex(hex.startIndex.advancedBy(2))
            var ch: UInt32 = 0
            NSScanner(string: c).scanHexInt(&ch)
            data.appendBytes(&ch, length: 1)
        }
        
        if let out = String(data: data, encoding: NSUTF8StringEncoding) {
            return out
        }
        
        return ""
    }
    
    func parseQRData(input: String) {
        
        if (HomeController.PassData.Mode == "HOSPITAL") {
            
            if ((input.rangeOfString(";")) != nil && input.componentsSeparatedByString(";")[0] == "ANSV") {
                
                var splitStr = input.componentsSeparatedByString(";")

                
                sections = ["Mã bệnh nhân", "Họ tên", "Năm sinh", "Mã BHYT"]
                
                items[0][0] = splitStr[1]
                items[1][0] = splitStr[2]
                items[2][0] = splitStr[3]
                items[3][0] = splitStr[4]
                
                tableView.reloadData()
                
            } else if ((input.rangeOfString("|")) != nil) {
                
                var splitStr = input.componentsSeparatedByString("|")

                sections = ["Số thẻ", "Họ tên", "Ngày sinh", "Giới tính", "Địa chỉ", "Mã", "Thời hạn sử dụng"]
                
                items[0][0] = splitStr[0]                       // SoThe
                items[1][0] = convertHexToString(splitStr[1])   // HoTen
                items[2][0] = splitStr[2]                       // NgaySinh
                items[4][0] = convertHexToString(splitStr[4])   // DiaChi
                items[5][0] = splitStr[5]                       // Ma
                items[6][0] = "\(splitStr[6]) - \(splitStr[7])" // ThoiHanSuDung
                
                if (splitStr[3] == "1") {
                    items[3][0] = "Nam"                       // GioiTinh
                } else if (splitStr[3] == "0") {
                    items[3][0] = "Nữ"
                }
                
                tableView.reloadData()
                
            } else {
                
                sections = ["Lỗi"]
                items[0][0] = "Không thuộc thẻ của bệnh viện"
                tableView.reloadData()
                
            }
            
            
        } else if (HomeController.PassData.Mode == "OTHER") {
                        
        }
    }
    
    // HEADER
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: HeaderCell = (tableView.dequeueReusableHeaderFooterViewWithIdentifier(header_cell) as? HeaderCell)!
        
        for i in 0..<sections.count {
            if (section == i) {
                header.title.text = "\(sections[i])"
            }
        }

        return header
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    // BODY
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: DetailCell = tableView.dequeueReusableCellWithIdentifier(detail_cell, forIndexPath: indexPath) as! DetailCell
        cell.informationLabel.text = self.items[indexPath.section][indexPath.row]
        return cell
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
}