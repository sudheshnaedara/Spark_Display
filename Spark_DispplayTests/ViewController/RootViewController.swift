//
//  RootViewController.swift
//  Spark_DispplayTests
//
//  Created by SparkMac on 09/11/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import XCTest
import Alamofire
import ReachabilitySwift

@testable import Spark_Dispplay

class RootViewController: XCTestCase {
     var window: UIWindow?
    var initialVC: ViewController?
    var image: UIImage?
    var imageView: UIImageView?
    
    override func setUp() {
        super.setUp()
        if let navController = UIApplication.shared.keyWindow!.rootViewController as? UINavigationController {
            let childViewController = navController.childViewControllers.first
            initialVC = childViewController as? ViewController
        }
    }
    
    func testViewDidLoad() {
        XCTAssertNotNil(initialVC?.viewDidLoad())
    }
    func testTableView(){
        XCTAssertNotNil(initialVC?.tableview)
    }
    func testThatViewConformsToUITableViewDatasource(){
        XCTAssertTrue((self.initialVC?.conforms(to: UITableViewDataSource.self))!, "View Controller does not conform to UITableView delegate protocol")
    }
    
    func testThatTableViewHasDataSource(){
        XCTAssertNotNil(self.initialVC?.tableview.dataSource, "TableView datasource can't be nil")
    }

    func testTableViewCell() {

        guard let factCell = initialVC?.tableview.dequeueReusableCell(withIdentifier: "FactTableViewCellIdentifier") as? FactTableViewCell else {return}
        XCTAssertNotNil(factCell, "No Fact Cell Available")
    
        let indexPath = NSIndexPath(row: 0, section: 0)
        if  self.initialVC?.rowArray.count != 0 {
            let dict = self.initialVC?.rowArray[indexPath.row]
            factCell.viewModel = dict
            let title = self.initialVC?.rowArray[indexPath.row].title
            let description = self.initialVC?.rowArray[indexPath.row].description
            
            XCTAssertNotNil(factCell.awakeFromNib())
            XCTAssertNotNil(factCell.setSelected(true, animated: true))
            XCTAssertEqual("Beavers", title)
            XCTAssertEqual("Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony", description)
    
            if factCell.imgView.image == nil {
              image =  UIImage(named: "NoImg")
                imageView = UIImageView(image: image)
                if let unwrappedImageView = imageView {
                    XCTAssert(unwrappedImageView.image != nil)
                } else {
                    XCTAssert(false)
                }
            }
        }
    }

    override func tearDown() {
        super.tearDown()
        initialVC = nil
    }
    
    func testAPICall() {
    let expectedResult = expectation(description: "Expecting a JSON data not nil")
    Alamofire.request("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json").responseString { responseData in
            XCTAssertNil(responseData.result.error)
         if let err = responseData.result.error {
         let errorMessage = messageFromError(error: err as NSError)
             XCTAssertNil(errorMessage)
        }
        let error = NSError.init()
        let errorResult = messageFromError(error: error)
        XCTAssertEqual(errorResult.0, "Alert")
        XCTAssertEqual(errorResult.1, "Failed with error 0")
        
        XCTAssertNotNil(responseData.result.value)
        if let data = responseData.result.value?.data(using: .utf8) {
            let json = parseData(JSONData: data)
            XCTAssertEqual(json.title, "About Canada")
            XCTAssertNotNil(json.rows,"Json Data not empty")
            self.initialVC?.tableview.reloadData()
            let decodedJson = try! JSONDecoder().decode(Fact.self, from: data)
            XCTAssertNotNil(decodedJson,"Decoded Json Cannot be NIl")
            expectedResult.fulfill()
        }
        }
        waitForExpectations(timeout: 60) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
        func testNoOfRows() {
            XCTAssertEqual(self.initialVC?.tableView((self.initialVC?.tableview)!, numberOfRowsInSection: 0),14)
    }


    func testRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(initialVC, action: #selector(ViewController.refresh(_:)), for: .valueChanged)
        refreshControl.sendActions(for: .valueChanged)
    }
    func testNetworkConnection() {
     initialVC?.checkNetworkConnection()
          let networkStatus = ReachabilityManager.shared.reachability.currentReachabilityStatus
         let expectedResult = expectation(description: "Expecting network Connection")
        XCTAssertTrue(networkStatus  == .reachableViaWiFi, "Should be connected to internet")
          expectedResult.fulfill()
        waitForExpectations(timeout: 60) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
 
    func testPerformanceExample() {
        self.measure {
        }
    }
}
