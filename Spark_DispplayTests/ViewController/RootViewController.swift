//
//  RootViewController.swift
//  Spark_DispplayTests
//
//  Created by SparkMac on 09/11/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import XCTest
@testable import Spark_Dispplay

class RootViewController: XCTestCase {
     var window: UIWindow?
    var initialVC: ViewController?
    
    override func setUp() {
        super.setUp()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
      let childView =   window?.rootViewController?.childViewControllers[0]
        initialVC = childView as? ViewController
        let _ = initialVC?.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        initialVC = nil
    }
    
    func testNoOfRows() {
        XCTAssertEqual(initialVC?.tableView((initialVC?.tableview)!, numberOfRowsInSection: 1),14)
    }
    func testCellForRow() {
        initialVC?.tableview.reloadData()
        let cell =  initialVC?.tableview.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is FactTableViewCell)
        
        let factCell = cell as? FactTableViewCell
         XCTAssertEqual("Beavers", factCell?.dataTitleLabel.text)
         XCTAssertEqual("Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony", factCell?.descriptionLabel.text)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
