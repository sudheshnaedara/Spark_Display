//
//  Fact.swift
//  DynamicCellHeightProgrammatic
//
//  Created by SparkMac on 05/11/18.
//  Copyright © 2018 Satinder. All rights reserved.
//

import Foundation
struct Fact : Codable {
    let title: String?
    let rows: [Rows]
}

struct Rows : Codable {
    let title : String?
    let description : String?
    let imageHref : URL?
    
    private enum CodingKeys : String, CodingKey {
        case title = "title"
        case description = "description"
        case imageHref = "imageHref"
    }
}

