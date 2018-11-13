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
import ReachabilitySwift

class ViewController: UIViewController , UITableViewDelegate{
    
    var refreshControl   = UIRefreshControl()
    fileprivate let factCellReuseIdentifier = "FactTableViewCellIdentifier"
    let tableview = UITableView()
    var rowArray = [rows]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.tableFooterView = UIView()
        configureTableView()
        addPullToRefresh()
        checkNetwork()
  }

    func addPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableview.addSubview(refreshControl)
    }
    @objc func refresh(_ sender: Any) {
         checkNetwork()
         self.refreshControl.endRefreshing()
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
        guard let cell = tableview.dequeueReusableCell(withIdentifier: factCellReuseIdentifier, for: indexPath) as? FactTableViewCell  else {
            return UITableViewCell()
        }
        cell.accessoryType = .disclosureIndicator
         let dict = self.rowArray[indexPath.row]
        cell.viewModel = dict
        return cell
    }
    
    func checkNetwork() {
      
        let networkStatus = ReachabilityManager.shared.reachability.currentReachabilityStatus
        print("networkStatus ++\(networkStatus)")
        if networkStatus  == .notReachable {
            let alert = UIAlertController(title: "", message: "Network Not Available", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: {
                  self.refreshControl.endRefreshing()
            })
        }else {
            APICall ()
        }
    }
    
    func APICall () {
    
        Alamofire.request("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json").responseString { responseData in
            guard responseData.result.error == nil else {
                print(responseData.result.error!)
                 self.refreshControl.endRefreshing()
                return
            }
            if((responseData.result.value) != nil) {
                if let data = responseData.result.value?.data(using: .utf8) {
                    let parsedData =  parseData(JSONData: data)
                    self.title = parsedData.title
                    self.rowArray = parsedData.rows
                    self.tableview.reloadData()
                }
            }
             self.refreshControl.endRefreshing()
        }
    }
}


