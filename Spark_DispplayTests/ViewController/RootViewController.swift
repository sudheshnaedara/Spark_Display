//
//  RootViewController.swift
//  Spark_DispplayTests
//
//  Created by SparkMac on 09/11/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import XCTest
import Alamofire

@testable import Spark_Dispplay

class RootViewController: XCTestCase {
     var window: UIWindow?
    var initialVC: ViewController?
     var rowArray = [Rows]()
    
    override func setUp() {
        super.setUp()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
      let childView =   window?.rootViewController?.childViewControllers[0]
        initialVC = childView as? ViewController
        let _ = initialVC?.view
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
    
    func testRecoveryTableViewCell() {

        _ = initialVC?.tableview.numberOfSections
        _ = initialVC?.tableview.numberOfRows(inSection: 0)
        guard let factCell = initialVC?.tableview.dequeueReusableCell(withIdentifier: "FactTableViewCellIdentifier") as? FactTableViewCell else {return}
        XCTAssertNotNil(factCell, "No Fact Cell Available")
        let indexPath = NSIndexPath(row: 0, section: 0)
        if rowArray.count > 0 {
            let title = self.rowArray[indexPath.row].title
            let description = self.rowArray[indexPath.row].description
            
            XCTAssertNotNil(factCell.awakeFromNib())
            XCTAssertNotNil(factCell.setSelected(true, animated: true))
            
            XCTAssertEqual("Beavers", title)
            XCTAssertEqual("Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony", description)
            XCTAssertNotNil(factCell.imgView.image)

        }
    }
    override func tearDown() {
        super.tearDown()
        initialVC = nil
    }
    
    func testGettingJSON() {
    let expectedResult = expectation(description: "Expecting a JSON data not nil")
    Alamofire.request("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json").responseString { responseData in
            XCTAssertNil(responseData.result.error)
            XCTAssertNotNil(responseData.result.value)
        print("responseData.result.value \(String(describing: responseData.result.value))")
            expectedResult.fulfill()
        }
        waitForExpectations(timeout: 60) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }

         initialVC?.tableview.reloadData()
    }

    

//    func testNoOfRows() {
//        XCTAssertEqual(initialVC?.tableView((initialVC?.tableview)!, numberOfRowsInSection: 1),14)
//    }
//    func testCellForRow() {
//        initialVC?.tableview.reloadData()
//        let cell =  initialVC?.tableview.cellForRow(at: IndexPath(row: 0, section: 0))
//
//        XCTAssertTrue(cell is FactTableViewCell)
//
//        let factCell = cell as? FactTableViewCell
//         XCTAssertEqual("Beavers", factCell?.titleLabel.text)
//         XCTAssertEqual("Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony", factCell?.descriptionLabel.text)
//    }
//

    
    func testRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(initialVC, action: #selector(ViewController.refresh(_:)), for: .valueChanged)
        refreshControl.sendActions(for: .valueChanged)
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
