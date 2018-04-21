//
//  EmpAddViewController.swift
//  Demo
//
//  Created by Dori on 4/21/18.
//  Copyright © 2018 Dori. All rights reserved.
//

import UIKit

class EmpAddViewController: UIViewController {

    @IBOutlet var btn_create: UIButton!
    @IBOutlet var tf_title: UITextField!
    @IBOutlet var tf_name: UITextField!
    @IBOutlet var tf_department: UITextField!
    @IBOutlet var tf_location: UITextField!
    var emp_id = Int()
    
    
    let postDictionary = NSDictionary()
    
    var e_name :String = ""
    var e_title :String = ""
    var e_department :String = ""
    var e_location :String = ""
  
    

    var dataArray = EmpTableViewDataModelItem(data: [:])
    
    func configureWithItem(item: EmpTableViewDataModelItem) {
   
        emp_id  = item.id!
        tf_name.text = item.name!
        tf_title.text = item.title!
        tf_department.text = item.department!
        tf_location.text = item.location!
//        setImageWithURL(url: item.ImageURL!)
        
         self.btn_create.setTitle("Update", for: .normal)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        load_view()
        
        if(dataArray != nil){
            self.configureWithItem(item: self.dataArray!)
        }
    }
    
    //set theme
    func load_view() {
    
        btn_create.setPreferences()
        tf_title.setPreferences()
        tf_name.setPreferences()
        tf_department.setPreferences()
        tf_location.setPreferences()
    
    }
    
    //Create button funcationality
    @IBAction func btn_create_action(_ sender: UIButton) {
        
        e_name = tf_name.text!
        e_title = tf_name.text!
        e_department = tf_department.text!
        e_location = tf_location.text!
        
        let checkedName =  checkIsEmpty(fieldName: e_name)
        let checkedTitle = checkIsEmpty(fieldName: e_title)
        let checkedDepart = checkIsEmpty(fieldName: e_department)
        let checkedLoc =  checkIsEmpty(fieldName: e_location)
    
        if(checkedName && checkedTitle && checkedDepart && checkedLoc){
            let param: [String: String] = [
                "name": self.e_name,
                "title": self.e_title,
                "department": self.e_department,
                "location": self.e_location
                ]
            self.posttEmployee(postData: param as NSDictionary)
        }
        
    }
    
    // check if a field is empty
    func checkIsEmpty(fieldName: String) -> Bool {
        if(fieldName == ""){
                let msg = "Please make sure to fill all fields"
                let alert = UIAlertController(title: "Employee", message: String(describing: msg), preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in}))
                self.present(alert, animated: true, completion: nil)
                return false
            }
            return true
    }
}

//Handling Add/Update Employee
extension EmpAddViewController{
    
    //Post Employee data http request
    //send parameters:
    //    "name": self.e_name,
    //    "title": self.e_title,
    //    "department": self.e_department,
    //    "location": self.e_location
    func posttEmployee(postData: NSDictionary) {
        
        let url = main_url+"/employee"
        let jsParser = Json_Parser()
        
        // you call the method with a trailing closure
        jsParser.jsonParsePostD(url, post: postData) {jsonString, statuscode in
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
    
    
    //Update Employee data http request
    //send data to update using dicationary and employee_id
    func updateEmployee(postData: NSDictionary, emp_id:String) {
        
        let url = main_url+"/employee?id="+emp_id
        let jsParser = Json_Parser()
        
        // you call the method with a trailing closure
        jsParser.jsonParsePut(url, put: postData) {jsonString, statuscode in
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
