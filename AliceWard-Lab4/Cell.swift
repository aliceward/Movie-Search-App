//
//  Cell.swift
//  AliceWard-Lab4
//
//  Created by Alice Ward on 10/22/18.
//  Copyright © 2018 Alice Ward. All rights reserved.
//

import Foundation
import UIKit

class Cell:UICollectionViewCell {
    
    @IBOutlet weak var smallMovieImage: UIImageView!
    @IBOutlet weak var smallMovieTitle: UILabel!
    

    var poster: UIImage!{
        didSet{
            smallMovieImage.image = poster
        }
    }
    

}
