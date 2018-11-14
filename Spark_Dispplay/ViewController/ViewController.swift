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
    fileprivate let factCellReuseIdentifier = StyleKit.cellIdentifier
    let tableview = UITableView()
    var rowArray = [Rows]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.tableFooterView = UIView()
        configureTableView()
        configureNavigationBar()
        pullToRefresh()
        checkNetworkConnection()
    }
    
    func configureNavigationBar() {
        let textAttributes = [NSAttributedStringKey.foregroundColor:StyleKit.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = StyleKit.navBackgroundBlue
        self.navigationController?.navigationBar.tintColor = StyleKit.white
    }
    
    func pullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: StyleKit.refreshText)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.tintColor = StyleKit.lightGray
        self.tableview.addSubview(refreshControl)
    }
    @objc func refresh(_ sender: Any) {
        checkNetworkConnection()
    }
    
    func configureTableView() {
        tableview.dataSource = self
        tableview.backgroundColor = StyleKit.tbleBackgroundLightGray
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
        let color = StyleKit.tbleBackgroundLightGray
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
            let alert = UIAlertController(title: "", message: StyleKit.networkAlertText, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:  StyleKit.okAlertText, style: UIAlertActionStyle.default,handler: { action in
                self.refreshControl.endRefreshing()
            }))
            self.present(alert, animated: true, completion: nil)
        }else {
            factAPICall ()
        }
    }
}


