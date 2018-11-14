//
//  FactCellViewModel.swift
//  Spark_Dispplay
//
//  Created by SparkMac on 08/11/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import Foundation

protocol FactCellViewModel {
    var rowItem: Rows { get }
    var titleText: String? { get }
    var descriptionText: String? { get }
    var imageHrefUrl: URL? { get }
}

extension Rows: FactCellViewModel {
    var rowItem: Rows {
        return self
    }
    var titleText: String? {
        return title
    }
    
    var descriptionText: String? {
        return description
    }
    
    var imageHrefUrl: URL? {
        return imageHref
    }
}

