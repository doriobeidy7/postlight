//
//  ListingViewController.swift
//  Demo
//
//  Created by Dori on 4/19/18.
//  Copyright © 2018 Dori. All rights reserved.
//

import UIKit


class EmpTableViewController: UIViewController {
    
    
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet var tableView: UITableView!
    private let dataSource = EmpTableViewDataModel()
    var page_id_count = 0
    var rowNumber = 0
    var detailViewController: EmpDetailsViewController? = nil
    var selectedRow = Int()
    var searchedEmployee = [EmpTableViewDataModelItem]()
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
    
        
        // Setup the Search Controller
        searchController.searchBar.placeholder = "Search Employee"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        // Set the searchBar in the navigation bar
        navigationItem.searchController = searchController
        definesPresentationContext = true
       
        // Setup the Filter Bar
        searchController.searchBar.scopeButtonTitles = ["Name", "Title", "Department", "Location"]
        searchController.searchBar.delegate = self
 
        
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
    
  
    // custom delete / update row
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let cell =  tableView.cellForRow(at: indexPath) as? EmpCell
        
        let delAction:UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "delete", handler: {_,_ in
            self.deleteEmployee(emp_id: String(cell!.emp_id))
            self.dataArray.remove(at: indexPath.row)
            tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        })
        delAction.backgroundColor = UIColor.red
        
        
        
        let updtAction:UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "update", handler: {_,_ in
         
           
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let EmpAddViewController = mainStoryboard.instantiateViewController(withIdentifier: "EmpAddViewController") as! EmpAddViewController
            EmpAddViewController.dataArray = self.dataArray[indexPath.row]
            self.navigationController?.pushViewController(EmpAddViewController, animated: true)
            
            
        })
        updtAction.backgroundColor = UIColor.employeeOrange
        
        return [updtAction, delAction]
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return dynamic array count => make tableview rows equal to dataArray size
        return dataArray.count 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row

        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let EmpDetailsViewController = mainStoryboard.instantiateViewController(withIdentifier: "EmpDetailsViewController") as! EmpDetailsViewController
        EmpDetailsViewController.dataArray = self.dataArray[indexPath.row]
          self.navigationController?.pushViewController(EmpDetailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightResize(1080, objh: 400)
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let navVC = segue.destination as? UINavigationController{
                if let empdetailsVC: EmpDetailsViewController = navVC.visibleViewController as? EmpDetailsViewController{
                    print("test")
                    empdetailsVC.dataArray = self.dataArray[selectedRow]
                }
                
                if let empaddVC: EmpAddViewController = navVC.visibleViewController as? EmpAddViewController{
                }
            }
        }
    }
    
    // MARK: - Private instance methods
    //clear tableView before loading searched data
    //Filtering data by type
    func filterContentForSearchText(_ searchText: String, scope: String) {
        self.dataArray.removeAll()
        dataSource.searchEmployee(type: scope.lowercased(), text:  searchText.lowercased())

    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
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

extension EmpTableViewController: UISearchBarDelegate {
    /// MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension EmpTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}


//Handling delete request
extension EmpTableViewController{
    //Delete Employee data http request
    //send employee id to delete an employee
    func deleteEmployee(emp_id:String) {
        
        let url = main_url+"/employee?id="+emp_id
        let jsParser = Json_Parser()
        
        // you call the method with a trailing closure
        jsParser.jsonParseDelete(url, delete: [:]) {jsonString, statuscode in
            if(statuscode ==  201){
                
                OperationQueue.main.addOperation(){
                    if(jsonString["message"] != nil){
                        let msg =  jsonString["message"] as! NSString
                        let alert = UIAlertController(title: "Employee", message: String(describing: msg), preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in}))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
            }else if(statuscode ==  400){
                
                OperationQueue.main.addOperation(){
                    
                    if(jsonString["error"] != nil){
                        let error =  jsonString["error"] as! NSDictionary
                        let msg =  error["message"] as! NSString
                        let alert = UIAlertController(title: "Employee", message: String(describing: msg), preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in}))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }else{
                print("smthg wrong = " + String(describing: statuscode))
                
            }
        }
        
    }
}
