//
//  StyleKit.swift
//  Spark_Dispplay
//
//  Created by SparkMac on 14/11/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import Foundation
import UIKit

open class StyleKit : NSObject {

    static var tbleBackgroundLightGray = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
    static var navBackgroundBlue = UIColor.init(red: 0/255, green: 51/255, blue: 160/255, alpha: 1.0)
    static var white = UIColor.white
    static var lightGray = UIColor.lightGray
    static var red = UIColor.red
    
    static var titleLableFont : UIFont = UIFont(name: "AvenirNext-DemiBold", size: 16)!
    static var descLableFont : UIFont = UIFont(name: "Avenir-Book", size: 13.5)!
    
     open class var titleNotAvailableText : String { return NSLocalizedString("Title not Available", comment: "Title Not Available") }
     open class var descNotAvailableText : String { return NSLocalizedString("Description not Available", comment: " Description Not Available") }
    
    open class var cellIdentifier : String { return NSLocalizedString("FactTableViewCellIdentifier", comment: "FactTableViewCellIdentifier") }
    open class var refreshText : String { return NSLocalizedString("Loading...", comment: "Loading...") }
    
    open class var networkAlertText : String { return NSLocalizedString("Please check your Internet connection", comment: "Please check your Internet connection") }
     open class var okAlertText : String { return NSLocalizedString("OK", comment: "OK") }
    
}
