//
//  EmpDetailsViewController.swift
//  Demo
//
//  Created by Dori on 4/21/18.
//  Copyright © 2018 Dori. All rights reserved.
//

import UIKit

class EmpDetailsViewController: UIViewController {
    
    @IBOutlet var lbl_name: UILabel!
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var lbl_department: UILabel!
    @IBOutlet var lbl_location: UILabel!
    var emp_id = Int()
    
     var dataArray = EmpTableViewDataModelItem(data: [:])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    func configureWithItem(item: EmpTableViewDataModelItem) {
        
        emp_id  = item.id!
        lbl_name.text = item.name!
        lbl_title.text = item.title!
        lbl_department.text = item.department!
        lbl_location.text = item.location!
        //      setImageWithURL(url: item.ImageURL!)
        
    }
    
}
