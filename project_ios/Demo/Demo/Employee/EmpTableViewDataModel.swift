//
//  EmpTableViewDataModel.swift
//  Demo
//
//  Created by Dori on 4/19/18.
//  Copyright © 2018 Dori. All rights reserved.
//
import UIKit

//protocol to handle data and error
protocol EmpTableViewDataModelDelegate: class {
    func didRecieveDataUpdate(data: [EmpTableViewDataModelItem])
    func didFailDataUpdateWithError(error: Error)
}

class EmpTableViewDataModel:NSObject {
    
    weak var delegate: EmpTableViewDataModelDelegate?
    
    private func handleError(error: Error) {}
    
    private func setDataWithResponse(response: [AnyObject]) {
       
        var data = [EmpTableViewDataModelItem]()
        for item in response {
            if let empTableViewDataModelItem = EmpTableViewDataModelItem(data: item as? NSDictionary) {
                
                data.append(empTableViewDataModelItem)
            }
        }
        delegate?.didRecieveDataUpdate(data: data)
    }
    
    
    func getEmployee(page_id:Int, limit:Int) {
        
        let url = main_url+"/employee?page_id="+String(page_id)+"&limit="+String(limit)
        let jsParser = Json_Parser()
        
        // you call the method with a trailing closure
        jsParser.jsonParseGet(url) {jsonString, statuscode in
            
            var data: NSDictionary? = nil
            let error: Error? = nil
           
    
            if(statuscode ==  200){
                
                data = jsonString as? NSDictionary
                let newdata = data?.value(forKey: "employee") as? NSArray
     
                if let error = error {
                    self.delegate?.didFailDataUpdateWithError(error: error)
                } else if newdata != nil {

               
                        self.setDataWithResponse(response: newdata! as [AnyObject])
                        
                    
                }
                
                DispatchQueue.main.async(execute: { () -> Void in

                })
                
                
            }else if(statuscode ==  400){
                
                OperationQueue.main.addOperation(){
                    
                    if(jsonString["non_field_errors"] != nil){
                        
                        let msg =  jsonString["non_field_errors"] as! NSString
                        let alert = UIAlertController(title: "Employee", message: String(describing: msg), preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in}))
//                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                }
            }else{
                print("smthg wrong = " + String(describing: statuscode))
                
            }
        }
        
    }
    
}



