//
//  FilmService.swift
//  Cinema
//
//  Created by Adrien Cullier on 08/07/2021.
//

import Foundation
import UIKit

let apiKey = "f6c576993e39ad6e37e6b9057a1ab449"
let region = "FR"
let language = "fr-FR"

struct FilmService {
    
    static var shared = FilmService()
    private init (){}
    
    var filmArray = [Film]()
    
    static private let filmUrl = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)&language=\(language)&page=1&region=\(region)")
    
   
    
    
  
    
    private var task : URLSessionDataTask?
    
    
    
    mutating func getFilmsRelease(callback : @escaping(Bool, FilmsResults?)->Void) {
        
        var request = URLRequest(url: FilmService.filmUrl!)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        task = session.dataTask(with: request) {
            (data, response, error) in
            
            DispatchQueue.main.async {
                
                guard let data = data, error == nil
                else{
                    callback(false, nil)
                    print ("Error1")
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200
                else{
                    callback(false, nil)
                    print ("Error2")
                    return
                }
               
                guard let responseJSON = try? JSONDecoder().decode(FilmsResults.self, from: (data))
                
                else {
                    callback(false, nil)
                    print ("Eh oui, Error3")
                    return
                }
                
                callback(true, responseJSON)
                
                let name = Notification.Name(rawValue: "filmsLoaded")
                let notification = Notification(name: name)
                NotificationCenter.default.post(notification)
     
            }
            
        }
        task?.resume()
        
    }
 
    mutating func getTrailer (filmId : String, callback : @escaping(Bool, String)->Void){
    
    let trailerURL = URL(string:"https://api.themoviedb.org/3/movie/\(filmId)/videos?api_key=\(apiKey)&language=en-US")
        
        var request = URLRequest(url: trailerURL!)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        task = session.dataTask(with: request) {
            (data, response, error) in
            
            DispatchQueue.main.async {
            guard let data = data, error == nil
            else{
                print("trailer error 1")
                callback(false, "")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200
            else {
              
                print("trailer error 2")
                callback(false, "")
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(FilmTrailerResults.self, from: data)
            else{
                print("trailer error 3")
                callback(false, "")
                return
            }
                
            
            var trailerKeyYoutube = ""
                for trailer in responseJSON.results {
                guard trailer.key != "", trailer.site == "YouTube", trailer.type == "Trailer"
                else {
                    print(trailer.key)
                    trailerKeyYoutube = ""
                    return
                }
                trailerKeyYoutube = trailer.key
            }
            
            
            
            
            callback(true, trailerKeyYoutube)
            
            let name = Notification.Name(rawValue: "trailerFilmLoaded")
            let notification = Notification(name: name)
            NotificationCenter.default.post(notification)
          
    }
        }
        task?.resume()

    }
}
    
    
    
    
    
   


func getDate (dateString : String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    var dateDef = ""
    if dateString != ""{
        let date = dateFormatter.date(from: dateString)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd MMMM"
        dateFormatter2.locale = Locale(identifier: "FR-fr")
        dateDef = dateFormatter2.string(from: date ?? Date())
    }
    else {
        dateDef = ""
    }
    return dateDef
}

func saveFilm (filmArray : Set<Film>)  {
   
    
    for element in filmArray {
         
        if FilmDB.all.contains(where : {$0.title == element.title}) == false {
            let favoriteFilm = FilmDB(context: AppDelegate.viewContext)
            favoriteFilm.title = element.title
            favoriteFilm.original_language = element.original_language
            favoriteFilm.overview = element.overview
            favoriteFilm.poster_path = element.poster_path
            favoriteFilm.release_date = element.release_date
            favoriteFilm.filmId = Int64(element.id)
            try? AppDelegate.viewContext.save()
            print ("Le nouvel élément a bien été enregistré, \(favoriteFilm.filmId)")
        }
        else if FilmDB.all.contains(where: {$0.title == element.title}) == true{
            
            for film in FilmDB.all {
                if film.title == element.title {
                    film.setValue(element.original_language, forKey: "original_language")
                    film.setValue(element.overview, forKey: "overview")
                    film.setValue(element.poster_path, forKey: "poster_path")
                    film.setValue(element.release_date, forKey: "release_date")
                    film.setValue(Int64(element.id), forKey: "filmId")
                }
            }
            
            try? AppDelegate.viewContext.save()
            print ("Les données du film \(element.title) ont bien été mises à jour, \(element.id)")
        }
        else {
            
           print ("Les film existe déjà mais les données n'ont pas été mises à jour...")
        }
        
    }}



func deleteFromFavorite (film : FilmDB) {
    film.setValue(false , forKey: "isFavorite")
    print(film.title!, film.isFavorite)
    try? AppDelegate.viewContext.save()
    
}



func noDeleteFilm (film : FilmDB) {
    film.setValue(false , forKey: "isDelete")
    print("Film deleted", film.title!, film.isDelete)
    try? AppDelegate.viewContext.save()
}
    
    
   
    
    
    
    
func deleteAllFilms ()  {
    
    for element in FilmDB.all {
        
        AppDelegate.viewContext.delete(element)
        print ("l'élément \(element.title ?? "") a bien été supprimé ")
    }
    
    try? AppDelegate.viewContext.save()
    
}

    
func getImage (imagePath : String) -> UIImage  {
    
    let urlBase = "https://image.tmdb.org/t/p/original"
    var urlTot = URL(string: "")
    
    if imagePath != "errorImage" {
    urlTot = URL(string :(urlBase + imagePath))!
    }
    else {
    urlTot = URL(string: "errorFilm")
    }
    
    let imageData = try? Data(contentsOf: (urlTot ?? URL(string: ""))!)
    
    
    let image = UIImage(data: (imageData ?? Data(count: 1)))
    
    return image ?? UIImage(named: "error3")!
}
    
    


//func displayFavoriteFilm(){
//    let FilmDBTot = FilmDB.all
//    let sortedFilmDBTot = FilmDBTot.sorted{
//        $0.release_date ?? "" < $1.release_date ?? ""
//    }
//
//    for film in sortedFilmDBTot {
//        print (film.title ?? "", film.release_date ?? "")
//    }
//}


