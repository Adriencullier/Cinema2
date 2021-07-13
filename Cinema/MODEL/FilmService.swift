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
 
    func getImage (imagePath : String) -> Data {
        
        let urlBase = "https://image.tmdb.org/t/p/original"
        let urlTot = URL(string :(urlBase + imagePath))!
        
        let imageData = try! Data(contentsOf: urlTot)
        
        return imageData
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

