//
//  Movie.swift
//  AliceWard-Lab4
//
//  Created by Alice Ward on 10/22/18.
//  Copyright © 2018 Alice Ward. All rights reserved.
//

import Foundation
import UIKit

struct Movie:Decodable{
    let id:Int!
    let poster_path:String?
    let title:String
    let release_date:String!
    let rating:String!
    let score:Int!
    let overview:String!
    let popularity: Double

    
    init(id:Int, poster_path:String, title:String, release_date:String, rating:String, score:Int, overview:String, popularity:Double) {
        self.id = id
        self.poster_path = poster_path
        self.title = title
        self.release_date = release_date
        self.rating = rating
        self.score = score
        self.overview = overview
        self.popularity = popularity
    }
}

