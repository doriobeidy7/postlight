//
//  AppDelegate.swift
//  Demo
//
//  Created by Dori on 1/15/18.
//  Copyright © 2018 Dori. All rights reserved.
//

import UIKit
import CoreData
import SystemConfiguration

let main_url = "http://localhost:3001/postlight"
var appDelegate = AppDelegate()
let defaults = UserDefaults.standard

var bounds = UIScreen.main.nativeBounds
var screenwidth = bounds.size.width
var screenheight = bounds.size.height


var densityBounds = UIScreen.main.bounds
var densityX = densityBounds.size.width
var densityY = densityBounds.size.height

var densityDivX = screenwidth / densityX
var densityDivY = screenheight / densityY
var loader: Loader!
var activityView = UIActivityIndicatorView()
var loaderView = UIView()

//Width scale
func widthResize(_ objw: CGFloat) -> CGFloat{
    let HDw = 1080
    let objPercentage = (objw * 100) / CGFloat(HDw)
    let objSize = (objPercentage * screenwidth) / 100
    return objSize / densityDivX
}

//Height scale
func heightResize(_ objw: CGFloat, objh: CGFloat)-> CGFloat {
    let HDw = 1080;
    let objPercentage = (objw * 100) / CGFloat(HDw)
    let objSize = (objPercentage * screenwidth) / 100;
    let objHeigth = (objSize / objw) * (objh);
    return objHeigth / densityDivX;
}


var Navbar_Title : String = ""
var Navbar_Font : String = ""
var Navbar_icon : String = ""

let userDefaults = UserDefaults.standard
var sema = DispatchSemaphore( value: 0 )

func isInternetAvailable() -> Bool {
    
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    return (isReachable && !needsConnection)
}



func NoInternetAlert(v: UIViewController) {
    
    let message = "No Internet Connection"
    let doneBtn = "Ok"
  
    
    let ac = UIAlertController(title: "", message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: doneBtn, style: .default)
    {
        (result : UIAlertAction) -> Void in
    })
    v.present(ac, animated: true)
}

func alert_message(v: UIViewController, message: String, title: String, btn_title: String) {
    
    let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: btn_title, style: .default)
    {
        (result : UIAlertAction) -> Void in
    })
    v.present(ac, animated: true)
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let barButtonAppearance = UIBarButtonItem.appearance()
        barButtonAppearance.tintColor = UIColor(netHex: 0x555555)
        window?.tintColor = UIColor(netHex: 0xf8b20e)
        
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

