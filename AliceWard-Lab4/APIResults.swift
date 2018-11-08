//
//  APIResults.swift
//  AliceWard-Lab4
//
//  Created by Alice Ward on 10/22/18.
//  Copyright © 2018 Alice Ward. All rights reserved.
//

import Foundation

struct APIResults:Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    var results: [Movie]
}
