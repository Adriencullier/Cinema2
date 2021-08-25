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
        guard let films = try? AppDelegate.viewContext.fetch(request)
        else {
            return []
        }
        return films
    }
    
    
        
        
    

}
func getFavoriteFilm(releaseDate : String)-> [FilmDB] {
    
    let request : NSFetchRequest<FilmDB> = FilmDB.fetchRequest()
    request.predicate = NSPredicate(format: "isFavorite = %@ && isView = %@ && release_date =%@ ", NSNumber(value: true), NSNumber(value: false), releaseDate)
    guard let films = try? AppDelegate.viewContext.fetch(request)
    else {
        return []
    }
    let sortedFilms = films.sorted(by: {$0.release_date! < $1.release_date!})
    return sortedFilms
}

func getViewFilms() -> [FilmDB] {
    
    let request : NSFetchRequest<FilmDB> = FilmDB.fetchRequest()
    request.predicate = NSPredicate(format: "isView = %@", NSNumber(value: true))

    
    guard let films = try? AppDelegate.viewContext.fetch(request)
    else {
        return []
    }
    let sortedFilms = films.sorted(by: {$0.noteFilm > $1.noteFilm})
    return sortedFilms
}

func getFavoriteFilm2()-> [FilmDB] {
    
    let request : NSFetchRequest<FilmDB> = FilmDB.fetchRequest()
    request.predicate = NSPredicate(format: "isFavorite = %@ && isView = %@", NSNumber(value: true), NSNumber(value: true))
    guard let films = try? AppDelegate.viewContext.fetch(request)
    else {
        return []
    }
    let sortedFilms = films.sorted(by: {$0.release_date! < $1.release_date!})
    return sortedFilms
}

func getSectionArray() -> [String]{
    var sectionArray = [String]()
    
    let request : NSFetchRequest<FilmDB> = FilmDB.fetchRequest()
    request.predicate = NSPredicate(format: "isFavorite = %@ && isView = %@", NSNumber(value: true), NSNumber(value: false))
    

    guard let films = try? AppDelegate.viewContext.fetch(request)
    else {
        return []
    }
    let sortedFilms = films.sorted(by: {$0.release_date! < $1.release_date!})
    
    for film in sortedFilms {
        if sectionArray.contains(film.release_date!) == false {
            sectionArray.append(film.release_date!)
        }
        else{}
    }
    
    return sectionArray
}



struct Film : Decodable, Hashable {
    var original_language : String
    var poster_path : String
    var release_date : String
    var title : String
    var overview : String
    var id : Int
    
    enum CodingKeys : String, CodingKey {
        case original_language, poster_path, release_date, title, overview, id
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        original_language = try container.decodeIfPresent(String.self, forKey: .original_language) ?? "Langue originale non disponible pour le moment"
        poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path) ?? "errorImage"
        release_date = try container.decodeIfPresent(String.self, forKey: .release_date) ?? "Date de sortie non disponible pour le moment"
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? "Titre non disponible pour le moment"
        overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? "Résumé non disponible pour le moment"
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 12
    }
    
    
    
    
}

struct FilmTrailer : Decodable {
    var key : String
    var site : String
    var type : String
    
    enum CodingKeys : String, CodingKey {
        case key, site, type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        key = try container.decodeIfPresent(String.self, forKey: .key) ?? ""
        site = try container.decodeIfPresent(String.self, forKey: .site) ?? ""
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        
    }
    
}

struct FilmTrailerResults : Decodable{
    var results : [FilmTrailer]
}

struct FilmsResults : Decodable {
    var results : [Film]
}


