//
//  ViewController.swift
//  Spark_Dispplay
//
//  Created by SparkMac on 08/11/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import UIKit
//import Alamofire

class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate{
    
    fileprivate let factCellReuseIdentifier = "FactTableViewCellIdentifier"
    let tableview = UITableView()
    var details = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.tableFooterView = UIView()
        configureTableView()
        parseJSON()
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
    
    func parseJSON() {
        if let path = Bundle.main.path(forResource: "fact", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary<String,Any>
                if let dict = jsonResult {
                    if let headingTitle = dict["title"] as? String {
                        title = headingTitle
                    }
                    if let row = dict["rows"] as? [[String: Any]] {
                        for item in row {
                            var dict = [String:Any]()
                            dict["title"] =  item["title"]
                            dict["description"] = item["description"]
                            dict["imageHref"] = item["imageHref"]
                            self.details.append(dict)
                        }
                        tableview.reloadData()
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: factCellReuseIdentifier, for: indexPath) as! FactTableViewCell
        cell.accessoryType = .disclosureIndicator
        let dict = self.details[indexPath.row]
        if  let title = dict["title"] , let description =   dict["description"] ,  let imageUrl = dict["imageHref"]  {
            cell.titleLabel.text = title as? String ?? "Title not available"
            cell.descriptionLabel.text = description as? String ?? "Description not available"
            if imageUrl  is NSNull {
                print("imageUrl \(indexPath.row) === \(imageUrl)")
            }else {
                 print("imageUrl \(indexPath.row) === \(imageUrl)")
                cell.imgView.downloaded(from: (imageUrl as? String)!)
            }
        }
        return cell
    }
}
extension UIImageView {
    
    func downloaded(from url: URL) {
        contentMode = .scaleAspectFit
     let configuration = URLSessionConfiguration.default
       // configuration.timeoutIntervalForRequest = TimeInterval(60)
       // configuration.timeoutIntervalForResource = TimeInterval(60)
        let session = URLSession(configuration: configuration)
        session.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
}
