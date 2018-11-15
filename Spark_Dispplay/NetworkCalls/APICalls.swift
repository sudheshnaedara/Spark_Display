//
//  APICalls.swift
//  Spark_Dispplay
//
//  Created by SparkMac on 14/11/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import Foundation
import Alamofire

extension ViewController {
    func factAPICall () {
        Alamofire.request("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json").responseString { responseData in
                if let err = responseData.result.error {
                    let errorMessage = messageFromError(error: err as NSError)
                     let alertController = UIAlertController(title: errorMessage.0, message: errorMessage.1, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title:  StyleKit.okAlertText, style: UIAlertActionStyle.default,handler: { action in
                        self.refreshControl.endRefreshing()
                    }))
                    self.present(alertController, animated: true, completion: nil)
            }
            if((responseData.result.value) != nil) {
                if let data = responseData.result.value?.data(using: .utf8) {
                    let parsedData =  parseData(JSONData: data)
                    self.title = parsedData.title
                    self.rowArray = parsedData.rows
                    self.refreshControl.endRefreshing()
                    self.tableview.reloadData()
                }
            }
        }
    }
}
