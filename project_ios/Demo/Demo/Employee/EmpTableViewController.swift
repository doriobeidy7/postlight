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
    var latestDataCount = 0
    var page_id_count = 0
    var rowNumber = 0
    fileprivate var dataArrayLatest = [EmpTableViewDataModelItem]()
    fileprivate var dataArray = [EmpTableViewDataModelItem]() {
        didSet {
            
            //Reload tableview after receiving data using EmpTableViewDataModelDelegate protocol to get data.
             DispatchQueue.main.async(execute: { () -> Void in
                self.tableView?.reloadData()
                self.page_id_count =  self.page_id_count + 1
                self.tableView.tableViewScrollToBottom(animated: true, rowNumber: self.rowNumber)
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
        loadEmpList()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
       
    }
    
    func loadEmpList(){
        dataSource.getEmployee(page_id: page_id_count, limit: 5)
    }
}



extension EmpTableViewController: UITableViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       
        let endScrolling:CGFloat = scrollView.contentOffset.y + scrollView.frame.size.height
        
        if(endScrolling >= scrollView.contentSize.height){

            //                NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "loadDataDelayed", userInfo: nil, repeats: false)
            
           loadEmpList()
        }
    }
}


extension EmpTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        // safe-unwrap => if it succeeds, => return custom cell.
        if let cell = tableView.dequeueReusableCell(withIdentifier: EmpCell.identifier, for: indexPath) as? EmpCell
        {
            
            cell.configureWithItem(item: dataArray[indexPath.item])

            return cell
        }
        
        // If safe-unwrap fails => return default UITableViewCell.
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return dynamic array count => make tableview rows equal to dataArray size
        return dataArray.count 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightResize(1080, objh: 400)
    }
}

extension EmpTableViewController: EmpTableViewDataModelDelegate {
    func didFailDataUpdateWithError(error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
    func didRecieveDataUpdate(data: [EmpTableViewDataModelItem]) {

        if(data.count  > 0){
            self.rowNumber =  self.dataArray.count
            dataArray.append(contentsOf: data)
        }
        
    }
}


