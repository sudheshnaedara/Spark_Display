//
//  JsonParsing.swift
//  Spark_Dispplay
//
//  Created by SparkMac on 08/11/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import Foundation

func parseData(JSONData: Data) -> Fact {
    do {
        let jsonData = try JSONDecoder().decode(Fact.self, from: JSONData)
        return jsonData
    } catch {
        print(error)
    }
    return Fact(title: nil, rows: [Rows]())
}
