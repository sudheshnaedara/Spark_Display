//
//  JsonParsing.swift
//  Spark_Dispplay
//
//  Created by SparkMac on 08/11/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import Foundation

func jsonDecode() -> fact {
    
    if let path = Bundle.main.path(forResource: "fact", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonData = try JSONDecoder().decode(fact.self, from: data)
            return jsonData
//            title = jsonData.title
//            rowArray = jsonData.rows
        } catch {
            print(error)
        }
    }
    return fact(title: nil, rows: [rows]())
}
