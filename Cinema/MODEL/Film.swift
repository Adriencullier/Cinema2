//
//  Film.swift
//  Cinema
//
//  Created by Adrien Cullier on 08/07/2021.
//

import Foundation
import UIKit

struct Film : Decodable {
    var title : String
    var release_date : String
    var poster_path : String
    var overview : String
    var original_language : String
}


struct FilmsResults : Decodable {
    var results : [Film]
}


