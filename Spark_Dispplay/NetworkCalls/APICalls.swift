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
            guard responseData.result.error == nil else {
                self.refreshControl.endRefreshing()
                return
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
