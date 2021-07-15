//
//  Film.swift
//  Cinema
//
//  Created by Adrien Cullier on 08/07/2021.
//

import Foundation
import UIKit
import CoreData

class FilmDB : NSManagedObject {
        
    static var all :  [FilmDB] {
        let request : NSFetchRequest<FilmDB> = FilmDB.fetchRequest()
        guard let persons = try? AppDelegate.viewContext.fetch(request)
        else {
            return []
        }
        return persons
    }
    
}

struct Film : Decodable, Hashable {
    var title : String
    var release_date : String
    var poster_path : String
    var overview : String
    var original_language : String
}


struct FilmsResults : Decodable {
    var results : [Film]
}


