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
    
    let nameLabel = UILabel()
    let titleLabel = UILabel()
    let departmentLabel = UILabel()
    let lcoationLabel = UILabel()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureWithItem(item: EmpTableViewDataModelItem) {

        nameLabel.text = item.name
        titleLabel.text = item.title
        departmentLabel.text = item.department
        lcoationLabel.text = item.location
        //setImageWithURL(url: item.ImageURL)
    }
    
    
 
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = UIColor.black
        
        titleLabel.frame = CGRect(x: 10, y: 0, width: widthResize(300), height: 50)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.white
        
        let fontSize = (densityX * 4.185) / 100
        titleLabel.font = UIFont (name: "CenturyGothic-Bold", size: fontSize)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 2
        
        
        nameLabel.frame = CGRect(x: widthResize(1080/2) - widthResize(100), y: 0, width: widthResize(200), height: 50)
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont (name: "CenturyGothic-Bold", size: fontSize)
        
        departmentLabel.frame = CGRect(x: densityX - 80, y: 0, width: 70, height: 50)
        departmentLabel.textColor = UIColor.white
        departmentLabel.font = UIFont (name: "CenturyGothic-Bold", size: fontSize)
        departmentLabel.textAlignment = .right
        
        lcoationLabel.frame = CGRect(x: densityX - 80, y: 0, width: 70, height: 50)
        lcoationLabel.textColor = UIColor.white
        lcoationLabel.font = UIFont (name: "CenturyGothic-Bold", size: fontSize)
        lcoationLabel.textAlignment = .right
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(departmentLabel)
        contentView.addSubview(lcoationLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
