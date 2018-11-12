//
//  ViewController.swift
//  Spark_Dispplay
//
//  Created by SparkMac on 08/11/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import UIKit
//import Alamofire

class ViewController: UIViewController , UITableViewDelegate{
    
    fileprivate let factCellReuseIdentifier = "FactTableViewCellIdentifier"
    let tableview = UITableView()
    var rowArray = [rows]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.tableFooterView = UIView()
        configureTableView()
         assignJsonValue()
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
  func   assignJsonValue() {
    let jsonObj = jsonDecode()
    title = jsonObj.title
    rowArray = jsonObj.rows
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
         let dict = self.rowArray[indexPath.row]
        cell.viewModel = dict
        return cell
    }
}


