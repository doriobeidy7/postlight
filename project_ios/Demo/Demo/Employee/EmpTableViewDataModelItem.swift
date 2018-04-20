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
    init?(data: NSDictionary?) {
        if let data = data, let name = data["name"], let title = data["title"], let department = data["department"], let location = data["location"] {
//            self.ImageURL = emp_image as? String
            self.name = "Name: " + (name as? String)!
            self.title = "Title: " + (title as? String)!
            self.department = "Department: " + (department as? String)!
            self.location = "Location: " + (location as? String)!
        } else {
            return nil
        }
    }
    
}
