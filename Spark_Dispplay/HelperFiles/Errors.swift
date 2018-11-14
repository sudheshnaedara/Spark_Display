//
//  Errors.swift
//  Spark_Dispplay
//
//  Created by SparkMac on 14/11/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import Foundation

func messageFromError(error: NSError!) -> (String, String) {
    var title: String = ""
    var message: String = ""
    if error !=  nil {
        switch (error.code) {
        case 310:
            title = NSLocalizedString("",comment:"")
            message = NSLocalizedString("Please Change your network and try again",comment:"Please Change your network and try again")
        case 311:
            title = NSLocalizedString("",comment:"")
            message = NSLocalizedString("Please Change your network and try again",comment:"Please Change your network and try again")
        default:
            title = NSLocalizedString("Alert",comment:"Error")
            message = "Failed with error \(error.code)"
        }
    }
    
    return (title, message)
}

func errorFromJson(errorMessage:String ,errorCode: String) -> (String, String) {
        var title: String = ""
        var message: String = ""
        
        if (errorCode !=  "") {
            switch (errorCode) {
            case "301":
                title = NSLocalizedString("",comment:"")
                message = NSLocalizedString("Please Change your network and try again",comment:"Please Change your network and try again")
            case "311":
                title = NSLocalizedString("",comment:"")
                message = NSLocalizedString("Please Change your network and try again",comment:"Please Change your network and try again")
                
            default:
                title = NSLocalizedString("Alert",comment:"Error")
                message = "\(errorMessage)"
            }
        }
        else {
            title = NSLocalizedString("Alert",comment:"")
            message = NSLocalizedString("Please try again later",comment: "")
            return (title, message)
        }
        
        return (title, message)
}
