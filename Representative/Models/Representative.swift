//
//  Representative.swift
//  Representative
//
//  Created by Dustin Koch on 5/16/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation

struct TopLevelJSONDictionary: Decodable {
    let results: [Representative]
}

struct Representative: Decodable {
    
    let name: String
    let party: String
    let district: String
    let phone: String
    let office: String
    let url: URL?
    
    enum CodingKeys: String, CodingKey {
        case name
        case party
        case district
        case office
        case phone
        case url = "link"
    }
    
}


