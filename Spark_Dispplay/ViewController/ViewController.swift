//
//  ViewController.swift
//  Spark_Dispplay
//
//  Created by SparkMac on 08/11/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import UIKit
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
        configureNavigationBar()
        pullToRefresh()
        checkNetworkConnection()
    }
    
    func configureNavigationBar() {
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0/255, green: 51/255, blue: 160/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func pullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.lightGray
        self.tableview.addSubview(refreshControl)
    }
    @objc func refresh(_ sender: Any) {
        checkNetworkConnection()
    }
    
    func configureTableView() {
        tableview.dataSource = self
        tableview.backgroundColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
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
        let color = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        cell.layer.borderColor = color.cgColor
        cell.layer.borderWidth = 5
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
 if cell.imgView.image == nil {
 cell.imgView.image = UIImage(named: "NoImg")
  }
        let dict = self.rowArray[indexPath.row]
        cell.viewModel = dict
        return cell
    }
    
    func checkNetworkConnection() {
        refreshControl.beginRefreshing()
        let networkStatus = ReachabilityManager.shared.reachability.currentReachabilityStatus
        if networkStatus  == .notReachable {
            let alert = UIAlertController(title: "", message: "Please check your Internet connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: { action in
                self.refreshControl.endRefreshing()
            }))
            self.present(alert, animated: true, completion: nil)
        }else {
            factAPICall ()
        }
    }
    
}


