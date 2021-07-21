//
//  FilmDescriptionViewController.swift
//  Cinema
//
//  Created by Adrien Cullier on 16/07/2021.
//

import UIKit
import WebKit

class FilmDescriptionViewController: UIViewController {

    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
   
    @IBOutlet weak var titleLabel: UILabel!
   
   
    @IBOutlet weak var trailerView: WKWebView!
    
    var key2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let film = UserDefaults.standard.object(forKey: "currentFilm") as? [String:String]
        
        
        titleLabel.text = film?["title"]
        descriptionText.text = film?["description"]
        
        releaseDateLabel.text = "Sortie en salle : \(getDate(dateString: film?["releaseDate"]! ?? ""))"
        languageLabel.text = "Langue originale : \"\(film?["originalLanguage"] ?? "")\""
        
       
        FilmService.shared.getTrailer(filmId: film!["filmId"] ?? "") { success, key in
            if success {
                print(film?["filmId"])
                self.key2 = key
                print ("Key 2 : \(self.key2)")
            }
            else {
                print(film?["filmId"])
                print("ya un soucis quelque part")
            }
        }
        
       
        
        
       
        let name = Notification.Name(rawValue: "trailerFilmLoaded")
        NotificationCenter.default.addObserver(self, selector: #selector(trailerFilmLoaded), name: name, object: nil)
    }
    
    @objc func trailerFilmLoaded (){
        let urlTrailer = URL(string: "https://www.youtube.com/embed/\(key2)")
        trailerView.load(URLRequest(url: urlTrailer!))
        print("urlTrailer : \(String(describing: urlTrailer))")
        
    }
   
    

  

}
