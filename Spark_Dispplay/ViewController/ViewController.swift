//
//  ViewController.swift
//  Spark_Dispplay
//
//  Created by SparkMac on 08/11/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController , UITableViewDelegate{
    
    fileprivate let factCellReuseIdentifier = "FactTableViewCellIdentifier"
    let tableview = UITableView()
    var rowArray = [rows]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.tableFooterView = UIView()
        configureTableView()
         APICall ()
  }
    
    func configureTableView() {
        tableview.dataSource = self
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.register(FactTableViewCell.self, forCellReuseIdentifier: factCellReuseIdentifier)
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
       
    }

}
extension ViewController :  UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return rowArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: factCellReuseIdentifier, for: indexPath) as! FactTableViewCell
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.accessoryType = .disclosureIndicator
//        cell.contentView.layer.cornerRadius = 10
//        cell.backgroundColor = UIColor.clear
//       cell.contentView.layer.borderWidth = 5
//        cell.contentView.layer.borderColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
     //   tableView.separatorStyle = .none
         let dict = self.rowArray[indexPath.row]
        cell.viewModel = dict
        return cell
    }

    func APICall () {

//    Alamofire.request("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json", method: .get)
//                .validate()
//                .responseData(completionHandler: { (responseData) in
//                    if responseData.error != nil {
//                        print("error\(String(describing: responseData.error))")
//                    }
//                    if responseData.data != nil {
//                        DispatchQueue.main.async {
//                            do {
//                                let jsonData = try JSONSerialization.data(withJSONObject: responseData.data, options: .prettyPrinted)
//                                let reqJSONStr = String(data: jsonData, encoding: .utf8)
//                                let data = reqJSONStr?.data(using: .utf8)
//                                print("jsonData \(jsonData), reqJSONStr \(reqJSONStr),data\(data)")
//                            }
//                            catch {
//
//                            }
//                     //    let parsedData =   self.parseData(JSONData: responseData.data!)
////                            self.image = UIImage(data: data)
//                        }
//                    }
//                })

        Alamofire.request("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json").responseString { responseData in
            if((responseData.result.value) != nil) {
                if let data = responseData.result.value?.data(using: .utf8) {
                    let parsedData =  parseData(JSONData: data)
                    self.title = parsedData.title
                    self.rowArray = parsedData.rows
                    self.tableview.reloadData()
                }
            }
        }
    }
}


