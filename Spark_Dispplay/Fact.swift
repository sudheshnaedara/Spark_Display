//
//  Fact.swift
//  DynamicCellHeightProgrammatic
//
//  Created by SparkMac on 05/11/18.
//  Copyright © 2018 Satinder. All rights reserved.
//

import Foundation

struct Fact: Decodable {
    let title: String
    let row: [Rows]
    
    enum CodingKeys : String, CodingKey {
        case title
        case row = "rows"
    }
}
struct Rows: Decodable {
    let title: String
    let description: String
    let imageHref: URL
}
