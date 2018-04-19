//
//  EmpTableViewDataModelItem.swift
//  Demo
//
//  Created by Dori on 4/19/18.
//  Copyright © 2018 Dori. All rights reserved.
//
import UIKit

class EmpTableViewDataModelItem {
    var ImageURL: String?
    var name: String?
    var title: String?
    var department: String?
    var location: String?
    
    
    //initialize data
    init?(data: [String: String]?) {
        if let data = data, let emp_image = data["emp_image"], let name = data["name"], let title = data["title"], let department = data["department"], let location = data["location"] {
            self.ImageURL = emp_image
            self.name = name
            self.title = title
            self.department = department
            self.location = location
        } else {
            return nil
        }
    }
    
}
