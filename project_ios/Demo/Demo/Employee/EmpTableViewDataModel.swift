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
    
    func requestData() {
        let data: [AnyObject]? = nil
        let error: Error? = nil
        
        if let error = error {
            delegate?.didFailDataUpdateWithError(error: error)
        } else if let data = data {
            setDataWithResponse(response: data)
        }
    }
    
    private func handleError(error: Error) {
        
    }
    
    private func setDataWithResponse(response: [AnyObject]) {
        var data = [EmpTableViewDataModelItem]()
        for item in response {
            if let drhTableViewDataModelItem = EmpTableViewDataModelItem(data: item as? [String: String]) {
                data.append(drhTableViewDataModelItem)
            }
        }
        delegate?.didRecieveDataUpdate(data: data)
    }

}



