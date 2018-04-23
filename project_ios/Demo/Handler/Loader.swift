//
//  Loader.swift
//  AbdaliMall
//
//  Created by Dori on 5/31/16.
//  Copyright © 2016 2pure. All rights reserved.
//

import UIKit

class Loader: UIView {
    
    var indicatorColor:UIColor
    var loadingViewColor:UIColor
    var loadingMessage:String
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var fontColor : UIColor = UIColor()
    
    init(inview:UIView,loadingViewColor:UIColor,indicatorColor:UIColor,msg:String, fontColor:UIColor){
        self.fontColor = fontColor
        self.indicatorColor = indicatorColor
        self.loadingViewColor = loadingViewColor
        self.loadingMessage = msg
        
        
        let cbtn :NSString = msg as NSString
        let cbw : CGSize = cbtn.size(withAttributes: [NSAttributedStringKey.font : UIFont(name: "Avenir-Roman", size: 40)!])
        
        super.init(frame: CGRect(x: inview.center.x - widthResize(200 + cbw.width)/2 ,y: inview.center.y , width: widthResize(200 + cbw.width)  , height: heightResize(1366, objh: cbw.height + 30)))
      
        
        initalizeCustomIndicator()
        
    }
    convenience init(inview:UIView) {
        
        self.init(inview: inview,loadingViewColor: UIColor.brown,indicatorColor:UIColor.black, msg: "Loading..", fontColor: UIColor.white)
    }
    convenience init(inview:UIView,messsage:String) {
        
        self.init(inview: inview,loadingViewColor: UIColor.brown,indicatorColor:UIColor.black, msg: messsage,fontColor:UIColor.white )
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func initalizeCustomIndicator(){
        
        let strLabel = UILabel()

        messageFrame.frame = self.bounds
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        activityIndicator.color = indicatorColor
        activityIndicator.hidesWhenStopped = true
        activityIndicator.frame.origin.x = widthResize(30)
        activityIndicator.center.y = messageFrame.center.y
        
        strLabel.text = loadingMessage
      
        
        strLabel.frame.origin.x = widthResize(100)
        strLabel.sizeToFit()
        strLabel.adjustsFontSizeToFitWidth = true
        strLabel.baselineAdjustment = .alignCenters
        strLabel.textColor = fontColor
        strLabel.center.y = messageFrame.center.y
        messageFrame.layer.cornerRadius = 5
        messageFrame.backgroundColor = loadingViewColor
        messageFrame.alpha = 0.8
        messageFrame.addSubview(activityIndicator)
        messageFrame.addSubview(strLabel)
        
        
    }
    
    func  start(){
        //check if view is already there or not..if again started
        if !self.subviews.contains(messageFrame){
            
            activityIndicator.startAnimating()
            self.addSubview(messageFrame)
            
        }
    }
    
    func stop(){
        
        if self.subviews.contains(messageFrame){
            
            activityIndicator.stopAnimating()
            messageFrame.removeFromSuperview()
            
        }
    }
}
