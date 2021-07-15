//
//  FilmService.swift
//  Cinema
//
//  Created by Adrien Cullier on 08/07/2021.
//

import Foundation

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
               
                guard let responseJSON = try? JSONDecoder().decode(FilmsResults.self, from: data)
                else {
                    callback(false, nil)
                    print ("Error3")
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
 
    
    
    func getDate (dateString : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd-MM"
        let dateDef = dateFormatter2.string(from: date!)
        
        return dateDef
    }
    
    
    
   
}

func saveFilm (film : Film)  {
   
    let favoriteFilm = FilmDB(context: AppDelegate.viewContext)
   
    favoriteFilm.title = film.title
    favoriteFilm.original_language = film.original_language
    favoriteFilm.overview = film.overview
    favoriteFilm.poster_path = film.poster_path
    favoriteFilm.release_date = film.release_date
    
    for element in FilmDB.all {
        if element.title != film.title{
            try? AppDelegate.viewContext.save()
            print ("Le nouvel élément a bien été enregistré")
        }
    else {
       print ("je n'ai pas sauvegardé cet élément car il existe déjà dans la base de données")
    }
    
    }}
    
func deleteAllFilms ()  {
    
    for element in FilmDB.all {
        
        AppDelegate.viewContext.delete(element)
        print ("l'élément \(element.title!) a bien été supprimé ")
    }
    
    try? AppDelegate.viewContext.save()
    
}

    
func getImage (imagePath : String) -> Data {
    
    let urlBase = "https://image.tmdb.org/t/p/original"
    let urlTot = URL(string :(urlBase + imagePath))!
    
    let imageData = try? Data(contentsOf: urlTot)
    
    return imageData ?? Data(count: 0)
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


