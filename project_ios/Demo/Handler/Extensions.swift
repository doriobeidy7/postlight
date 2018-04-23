//
//  Extensions.swift
//  Demo
//
//  Created by Dori on 1/29/18.
//  Copyright © 2018 Dori. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    static let employeeOrange = UIColor(netHex: 0xf8b20e)
}

extension UITextField{
    func setPreferences()  {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor(netHex: 0x898989).cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always

        paddingView.isUserInteractionEnabled = false
        self.rightView = paddingView
        self.rightViewMode = .unlessEditing
        let color = UIColor(netHex: 0x9d9b9b)
        
        let langString = "CenturyGothic-Bold"
        let fontSize = 18
     
        self.font = UIFont(name: langString, size: CGFloat(fontSize))!
        self.textColor = UIColor(netHex: 0x555555)
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.font : UIFont(name: langString, size: CGFloat(fontSize))!])
    
    }
    
    
}

extension UIButton{
    func setPreferences() {
        //        self.layer.shadowColor = UIColor.black.cgColor
        //        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        //        self.layer.shadowOpacity = 0.5
        //        self.layer.shadowRadius = 1.5
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(netHex: 0x898989).cgColor
        
                let langString = "CenturyGothic-Bold"
                let fontSize = 15
//                if(MOLHLanguage.isArabic()){
//                    self.contentHorizontalAlignment = .right
//                    langString = "FrutigerLTArabic-65Bold"
//                    fontSize = 15
//                }else{
//                    langString = "CenturyGothic-Bold"
//                    fontSize = 15
                    self.contentHorizontalAlignment = .center
//                }
    

        
        self.titleLabel?.font = UIFont(name: langString, size: CGFloat(fontSize))
        self.setTitleColor(UIColor(netHex: 0x555555), for: .normal)
        self.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
    }
    
    func setFont(){
        let langString = "CenturyGothic-Bold"
        let fontSize = 15
        self.setTitleColor(UIColor(netHex: 0x555555), for: .normal)
        self.contentHorizontalAlignment = .center
        self.titleLabel?.font = UIFont(name: langString, size: CGFloat(fontSize))
    }

    func loadingIndicator(_ show: Bool) {
        let tag = 808404
        if show {
            self.isEnabled = false
            self.alpha = 0.5
            let indicator = UIActivityIndicatorView()
            indicator.color = UIColor.black
         
            let buttonHeight = self.bounds.size.height
//            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: 15, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.isEnabled = true
            self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}

extension UIAlertController {
    
    func show() {
        present(animated: true, completion: nil)
    }
    
    func present(animated: Bool, completion: (() -> Void)?) {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            presentFromController(controller: rootVC, animated: animated, completion: completion)
        }
    }
    
    private func presentFromController(controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if let navVC = controller as? UINavigationController,
            let visibleVC = navVC.visibleViewController {
            presentFromController(controller: visibleVC, animated: animated, completion: completion)
        } else
            if let tabVC = controller as? UITabBarController,
                let selectedVC = tabVC.selectedViewController {
                presentFromController(controller: selectedVC, animated: animated, completion: completion)
            } else {
                controller.present(self, animated: animated, completion: completion)
        }
    }
}

extension UITableView {
    
    func tableViewScrollToBottom(animated: Bool, rowNumber: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(0)) {
            
            let numberOfSections = self.numberOfSections
            var numberOfRows = 0
            
            if numberOfSections != 0 {
                numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            }
            if numberOfRows > 0 {
            
                let indexPath = IndexPath(row: rowNumber, section: (numberOfSections-1))
                self.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: animated)
            }
        }
    }
    
}
