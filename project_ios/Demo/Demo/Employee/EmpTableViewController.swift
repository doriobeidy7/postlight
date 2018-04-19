//
//  ListingViewController.swift
//  Demo
//
//  Created by Dori on 4/19/18.
//  Copyright © 2018 Dori. All rights reserved.
//

import UIKit



class EmpTableViewController: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    private let dataSource = EmpTableViewDataModel()
    
    fileprivate var dataArray = [EmpTableViewDataModelItem]() {
        didSet {
            //Reload tableview after receiving data using EmpTableViewDataModelDelegate protocol to get data.
             DispatchQueue.main.async(execute: { () -> Void in
                self.tableView?.reloadData()
             })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        tableView.register(EmpCell.self, forCellReuseIdentifier: EmpCell.identifier)
        dataSource.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        dataSource.requestData()
    }
    
}

extension EmpTableViewController: UITableViewDelegate {}

extension EmpTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // safe-unwrap => if it succeeds, => return custom cell.
        if let cell = tableView.dequeueReusableCell(withIdentifier: EmpCell.identifier, for: indexPath) as? EmpCell
        {
//            let row = indexPath.row
//            cell.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//            cell.backgroundColor = UIColor.clear
//            cell.titleLabel.text = dataArray[row].title
//            print(dataArray)
            cell.configureWithItem(item: dataArray[indexPath.item])
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

extension EmpTableViewController: EmpTableViewDataModelDelegate {
    func didFailDataUpdateWithError(error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
    func didRecieveDataUpdate(data: [EmpTableViewDataModelItem]) {
        dataArray = data
//          print(data)
    }
}
