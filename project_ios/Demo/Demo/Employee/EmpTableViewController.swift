//
//  ListingViewController.swift
//  Demo
//
//  Created by Dori on 4/19/18.
//  Copyright © 2018 Dori. All rights reserved.
//

import UIKit



class EmpTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView: UITableView!
    fileprivate var dataArray = [EmpTableViewDataModelItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        tableView.register(EmpCell.nib, forCellReuseIdentifier: EmpCell.identifier)
        
    }
    
}

extension EmpTableViewController: UITableViewDelegate {}

extension EmpTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // safe-unwrap => if it succeeds, => return custom cell.
        if let cell = tableView.dequeueReusableCell(withIdentifier: EmpCell.identifier, for: indexPath) as? EmpCell
        {
            let row = indexPath.row
            cell.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            cell.backgroundColor = UIColor.clear
            cell.titleLabel.text = dataArray[row].title
            
            return cell
        }
        
        // If safe-unwrap fails => return default UITableViewCell.
        return UITableViewCell()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return dynamic array count => make tableview rows equal to dataArray size
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
