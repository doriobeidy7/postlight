///
//  Json_Parser.swift
//  AbdaliMall
//
//  Created by Dori on 5/30/16.
//  Copyright © 2016 2pure. All rights reserved.
//


import UIKit
import Foundation

class Json_Parser: UIViewController, NSURLConnectionDelegate {
    var error: NSError? = nil;
    let defaults = UserDefaults.standard
    
    // JSON PASRSER (POST)
    func jsonParsePostChat(_ url: String, post: NSDictionary, completion: @escaping (NSDictionary, NSNumber) -> ()) {
        if let url = URL(string: url) {
            let token:String = defaults.string(forKey: "token")!
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.addValue("en", forHTTPHeaderField:"Accept-Language")
//
            if(token != "" && defaults.object(forKey: "token") != nil){
                request.setValue("Token "+token, forHTTPHeaderField: "Authorization")
            }
            
            request.httpBody = try! JSONSerialization.data(withJSONObject: post, options: .prettyPrinted)
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: {
                data, response, error in
                
                // Check for error
                if error != nil
                {
                    let alertTitle = "Connection error."
                    let alertMessage = "No Internet Connection"
                    let retryButton = "Ok"
                    
                    
                  
                    
                    
                    let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: retryButton, style: UIAlertActionStyle.default, handler: {
                        (action:UIAlertAction!) in
                        completion([:] , 1009)
                    }))
                    alertController.show()
                    
                    return
                }
                
                if let data = data, error == nil {
                    
                    let httpResponse = response as! HTTPURLResponse
                    //        httpResponse.statusCode
                    
                    print(response as Any)
                    
                    do {
                        let jsonString =  try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                        completion(jsonString as! NSDictionary, httpResponse.statusCode as NSNumber)
                    } catch {
                        // Handle Error
                        print("Error with Json: \(error)")
                    }
                    
                    
                    
                } else {
                    print("error=\(error!.localizedDescription)")
                }
            })
            task.resume()
        }
    }
    // JSON PASRSER (POST)
    func jsonParsePostD(_ url: String, post: NSDictionary, completion: @escaping (NSDictionary, NSNumber) -> ()) {
        if let url = URL(string: url) {
           
            var request = URLRequest(url: url)
         
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if(defaults.object(forKey: "token") != nil){
                 let token:String = defaults.string(forKey: "token")!
                if(token != ""){
                    request.setValue("Token "+token, forHTTPHeaderField: "Authorization")
                    
                }
            }
            
            request.httpBody = try! JSONSerialization.data(withJSONObject: post, options: .prettyPrinted)
            
        
           
            let task = URLSession.shared.dataTask(with: request, completionHandler: {
                data, response, error in

                // Check for error
                if error != nil
                {
                    let alertTitle = "Connection error."
                    let alertMessage = "No Internet Connection"
                    let retryButton = "Ok"
                    
                    
                  
                    
                    
                    let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: retryButton, style: UIAlertActionStyle.default, handler: {
                        (action:UIAlertAction!) in
                        completion([:] , 1009)
                    }))
                    alertController.show()
                    
                    return 
                }
                
                if let data = data, error == nil {
                    
                    let httpResponse = response as! HTTPURLResponse
                    
                    do {
                        let jsonString =  try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                        completion(jsonString as! NSDictionary, httpResponse.statusCode as NSNumber)
                    } catch {
                        // Handle Error
                        print("Error with Json: \(error)")
                    }
      
                    
                } else {
                    print("error=\(error!.localizedDescription)")
                }
            }) 
            task.resume()
        }
    }
    
    
    // JSON PASRSER (POST)
    func jsonParsePost(_ url: String, post: String, completion: @escaping (NSDictionary, NSNumber) -> ()) {
        if let url = URL(string: url) {
            let token = defaults.object(forKey: "token") as? String
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.httpBody = post.data(using: String.Encoding.utf8)!
            
            if(token != "" && defaults.object(forKey: "token") != nil){
                request.setValue("Token "+token!, forHTTPHeaderField: "Authorization")
            }
            let task = URLSession.shared.dataTask(with: request, completionHandler: {
                data, response, error in
                
                // Check for error
                if error != nil
                {
                    let alertTitle = "Connection error."
                    let alertMessage = "No Internet Connection"
                    let retryButton = "Ok"
            
                    let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: retryButton, style: UIAlertActionStyle.default, handler: {
                        (action:UIAlertAction!) in
                        completion([:] , 1009)
                    }))
                    alertController.show()
                    
                    return 
                }
                
                
                if let data = data, error == nil {
                    
                    let httpResponse = response as! HTTPURLResponse
                    print(httpResponse)
                    
                    do {
                        let jsonString =  try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                        completion(jsonString as! NSDictionary, httpResponse.statusCode as NSNumber)
                    } catch {
                        // Handle Error
                        print("Error with Json: \(error)")
                    }
                    
                    
                    
                } else {
//                    let alert = UIAlertController(title: "Connection", message: String("No internet connection."), preferredStyle: UIAlertControllerStyle.Alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(action:UIAlertAction!) in}))
//                    self.navigationController?.presentingViewController!.presentViewController(alert, animated: true, completion: nil)
                    print("error=\(error!.localizedDescription)")
                }
            }) 
            task.resume()
        }
    }
    
    // JSON PASRSER (PUT)
    func jsonParsePut(_ url: String, put: NSDictionary, completion: @escaping (NSDictionary, NSNumber) -> ()) {
        if let url = URL(string: url) {
            let token:String = defaults.string(forKey: "token")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            
             request.setValue("application/json", forHTTPHeaderField: "Content-Type")
     
            if(token != "" && defaults.object(forKey: "token") != nil){
                request.setValue("Token "+token, forHTTPHeaderField: "Authorization")
            }
            

            request.httpBody = try! JSONSerialization.data(withJSONObject: put, options:[])
            // request.HTTPBody = put.dataUsingEncoding(NSUTF8StringEncoding)
            //
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: {
                data, response, error in
                
                // Check for error
                if error != nil
                {
                    let alertTitle = "Connection error."
                    let alertMessage = "No Internet Connection"
                    let retryButton = "Ok"
                    
        
                    
                    let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: retryButton, style: UIAlertActionStyle.default, handler: {
                        (action:UIAlertAction!) in
                        completion([:] , 1009)
                    }))
                    alertController.show()
                    
                    return 
                }
                
                if let data = data, error == nil {
                    
                    let httpResponse = response as! HTTPURLResponse

                    
                    do {
                        let jsonString =  try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                        completion(jsonString as! NSDictionary, httpResponse.statusCode as NSNumber)
                    } catch {
                        // Handle Error
                        print("Error with Json: \(error)")
                    }
                    
                    
                    
                } else {
                    print("error=\(error!.localizedDescription)")
                }
            }) 
            task.resume()
        }
    }
    
    // JSON PASRSER (DELETE)
    func jsonParseDelete(_ url: String, delete: [String: Any], completion: @escaping (NSDictionary, NSNumber) -> ()) {
        if let url = URL(string: url) {
            let tokenString:String = defaults.string(forKey: "token")!
            print(tokenString)
            
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            if(tokenString != "" && defaults.object(forKey: "token") != nil){
                request.addValue("Token \(tokenString)", forHTTPHeaderField: "Authorization")
            }
            request.httpMethod = "DELETE"
          //  request.httpBody = try! JSONSerialization.data(withJSONObject: delete, options:.prettyPrinted)
            let task = URLSession.shared.dataTask(with: request, completionHandler: {
                data, response, error in
                
                // Check for error
                if error != nil
                {
                    let alertTitle = "Connection error."
                    let alertMessage = "No Internet Connection"
                    let retryButton = "Ok"
                    
            
                    let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: retryButton, style: UIAlertActionStyle.default, handler: {
                        (action:UIAlertAction!) in
                        completion([:] , 1009)
                    }))
                    alertController.show()
                    
                    return 
                }
                
                if let data = data, error == nil {
                    
                    
                    let httpResponse = response as! HTTPURLResponse
          
                     print("Error with Json: \(httpResponse)")
                    do {
                        let jsonString =  try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                        completion(jsonString as! NSDictionary, httpResponse.statusCode as NSNumber)
                    } catch {
                        // Handle Error
                        print("Error with Json: \(error)")
                    }
                    
                    
                    
                } else {
                    print("error=\(error!.localizedDescription)")
                }
            }) 
            task.resume()
        }
    }
    
    
    func jsonParseGet(_ url: String, completion: @escaping (AnyObject, NSNumber) -> ())  {
        
        let token = defaults.object(forKey: "token") as? String
        let  url = url.replacingOccurrences(of: " ", with: "&")
        
        let myUrl = URL(string: url)
       
        var request = URLRequest(url: myUrl!)
        
        if token != "" && defaults.object(forKey: "token") != nil {
            request.addValue("Token "+token!, forHTTPHeaderField: "Authorization")
        }
        
       
        request.httpMethod = "GET"
        
        // Excute HTTP Request
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                let alertTitle = "Connection error."
                let alertMessage = "No Internet Connection"
                let retryButton = "Ok"
                
                
                
                
                
                let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
               
                alertController.addAction(UIAlertAction(title: retryButton, style: UIAlertActionStyle.default, handler: {
                    (action:UIAlertAction!) in
                    completion("" as AnyObject , 1009)
                }))
                alertController.show()
            
                return 
            }
            
    
            let httpResponse = response as! HTTPURLResponse
            do {
                if let jsonString =  try JSONSerialization.jsonObject(with: data!, options: []) as AnyObject? {
                    completion(jsonString , httpResponse.statusCode as NSNumber)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            
            
        }) 
        
        task.resume()
    }
    
    
    
    func jsonParseGetEn(_ url: String, completion: @escaping (AnyObject, NSNumber) -> ())  {
        
        let token = defaults.object(forKey: "token") as? String
        let  url = url.replacingOccurrences(of: " ", with: "&")
        
        let myUrl = URL(string: url)
        
        var request = URLRequest(url: myUrl!)
        
        if token != "" && defaults.object(forKey: "token") != nil {
            request.addValue("Token "+token!, forHTTPHeaderField: "Authorization")
        }
        request.addValue("en", forHTTPHeaderField:"Accept-Language")
        
        request.httpMethod = "GET"
        
        // Excute HTTP Request
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                let alertTitle = "Connection error."
                let alertMessage = "No Internet Connection"
                let retryButton = "Ok"
                
                
                
                
                let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: retryButton, style: UIAlertActionStyle.default, handler: {
                    (action:UIAlertAction!) in
                    completion("" as AnyObject , 1009)
                }))
                alertController.show()
                
                return
            }
            
            
            let httpResponse = response as! HTTPURLResponse
            do {
                if let jsonString =  try JSONSerialization.jsonObject(with: data!, options: []) as AnyObject? {
                    completion(jsonString , httpResponse.statusCode as NSNumber)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            
            
        })
        
        task.resume()
    }
}


