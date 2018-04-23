//
//  EmployeeCell.swift
//  Demo
//
//  Created by Dori on 4/19/18.
//  Copyright © 2018 Dori. All rights reserved.
//

import UIKit
class EmpCell: UITableViewCell {
    
    class var identifier: String {
        return String(describing: self)
    }
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    let layerView = UIView()
    let nameLabel = UILabel()
    let titleLabel = UILabel()
    let departmentLabel = UILabel()
    let lcoationLabel = UILabel()
    var emp_id = Int()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureWithItem(item: EmpTableViewDataModelItem) {

        emp_id  = item.id!
        nameLabel.text = "Name: " + item.name!
        titleLabel.text =  "Title: " + item.title!
        departmentLabel.text =  "Department: " + item.department!
        lcoationLabel.text =  "Location: " + item.location!
        //setImageWithURL(url: item.ImageURL)
    }
 
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = UIColor.white
        
        
        let fontSize = (densityX * 2.7) / 100
        
        titleLabel.frame = CGRect(x: 10, y: 0, width: widthResize(540), height: 30)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont (name: "CenturyGothic-Regular", size: fontSize)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 2
        
        
        nameLabel.frame = CGRect(x:10, y: 30, width: widthResize(540), height: 30)
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont (name: "CenturyGothic-Regular", size: fontSize)
        
        departmentLabel.frame = CGRect(x: 10, y: 60, width: widthResize(540), height: 30)
        departmentLabel.textColor = UIColor.black
        departmentLabel.font = UIFont (name: "CenturyGothic-Regular", size: fontSize)
        departmentLabel.textAlignment = .left
        
        lcoationLabel.frame = CGRect(x: 10 , y: 90, width: widthResize(540), height: 30)
        lcoationLabel.textColor = UIColor.black
        lcoationLabel.font = UIFont (name: "CenturyGothic-Regular", size: fontSize)
        lcoationLabel.textAlignment = .left
        
        layerView.addSubview(titleLabel)
        layerView.addSubview(nameLabel)
        layerView.addSubview(departmentLabel)
        layerView.addSubview(lcoationLabel)
        

        
        layerView.layer.shadowColor = UIColor.black.cgColor
        layerView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layerView.layer.shadowOpacity = 0.5
        layerView.layer.shadowRadius = 1.5
        layerView.layer.frame  = CGRect(x: 10, y: 10, width: densityX - 20, height: heightResize(1080, objh: 320))
        
        layerView.layer.masksToBounds = true
        layerView.layer.cornerRadius = 15
        layerView.layer.borderWidth = 0.4
        layerView.layer.borderColor = UIColor(netHex: 0x898989).cgColor
     
        contentView.addSubview(layerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
