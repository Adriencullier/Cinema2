//
//  FilmDescriptionViewController2ViewController.swift
//  Cinema
//
//  Created by Adrien Cullier on 20/07/2021.
//

import UIKit
import WebKit

class FilmDescriptionViewController2ViewController: UIViewController {
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var backButton: UIBarButtonItem!
  
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starOutlet1: UIButton!
    @IBOutlet weak var starOutlet2: UIButton!
    @IBOutlet weak var starOutlet3: UIButton!
    @IBOutlet weak var starOutlet4: UIButton!
    @IBOutlet weak var starOutlet5: UIButton!
    
    @IBOutlet weak var trailerView: WKWebView!
    
    var star1IsSelect = false
    var star2IsSelect = false
    var star3IsSelect = false
    var star4IsSelect = false
    var star5IsSelect = false
    
    var noteFilm = 0
    
    var key2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let film = UserDefaults.standard.object(forKey: "currentFilm2") as? [String:Any]
        
        titleLabel.text = film!["title"] as? String
        descriptionText.text = film!["description"] as? String
        
        releaseDateLabel.text = "Sortie en salle : \(getDate(dateString: (film!["releaseDate"] as? String)! ))"
        languageLabel.text = "Langue originale : \"\(film!["originalLanguage"] ?? "")\""
        
        FilmService.shared.getTrailer(filmId: (film!["filmId"] as? String)! ) { success, key in
            if success {
                self.key2 = key
            }
            else {
                
            
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

    

    
    @IBAction func deleteButton(_ sender: Any) {
        
        let film = UserDefaults.standard.object(forKey: "currentFilm2") as? [String:String]
        deleteFromFavorite(filmTitle: film!["title"] ?? "")
        
        }
        
    
    
    @IBAction func isViewButton(_ sender: Any) {
        let film = UserDefaults.standard.object(forKey: "currentFilm2") as? [String:String]
        isView(filmTitle: film!["title"] ?? "", noteFilm: Int64(noteFilm))
        
    }
    
    
    
    @IBAction func star1(_ sender: Any) {
        
        star1IsSelect.toggle()
        if star1IsSelect == false {
            noteFilm = 0
            starOutlet1.setImage(UIImage(systemName: "star"), for: .normal)
            star2IsSelect = false
            starOutlet2.setImage(UIImage(systemName: "star"), for: .normal)
            star3IsSelect = false
            starOutlet3.setImage(UIImage(systemName: "star"), for: .normal)
            star4IsSelect = false
            starOutlet4.setImage(UIImage(systemName: "star"), for: .normal)
            star5IsSelect = false
            starOutlet5.setImage(UIImage(systemName: "star"), for: .normal)
        }
        else {
            noteFilm = 1
            starOutlet1.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        print (noteFilm)
    }
    @IBAction func star2(_ sender: Any) {
      
        star2IsSelect.toggle()
        if star2IsSelect == false {
            noteFilm = 1
            starOutlet2.setImage(UIImage(systemName: "star"), for: .normal)
            star3IsSelect = false
            starOutlet3.setImage(UIImage(systemName: "star"), for: .normal)
            star4IsSelect = false
            starOutlet4.setImage(UIImage(systemName: "star"), for: .normal)
            star5IsSelect = false
            starOutlet5.setImage(UIImage(systemName: "star"), for: .normal)
        }
        else {
            noteFilm = 2
            star1IsSelect = true
            starOutlet1.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet2.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        print (noteFilm)
    }
    @IBAction func star3(_ sender: Any) {
       
        star3IsSelect.toggle()
        if star3IsSelect == false {
            noteFilm = 2
            starOutlet3.setImage(UIImage(systemName: "star"), for: .normal)
            star4IsSelect = false
            starOutlet4.setImage(UIImage(systemName: "star"), for: .normal)
            star5IsSelect = false
            starOutlet5.setImage(UIImage(systemName: "star"), for: .normal)
        }
        else {
            noteFilm = 3
            star1IsSelect = true
            star2IsSelect = true
            starOutlet1.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet2.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet3.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        print (noteFilm)
    }
    @IBAction func star4(_ sender: Any) {
        
        star4IsSelect.toggle()
        if star4IsSelect == false {
            noteFilm = 3
            starOutlet4.setImage(UIImage(systemName: "star"), for: .normal)
            star5IsSelect = false
            starOutlet5.setImage(UIImage(systemName: "star"), for: .normal)
            
        }
        else {
            noteFilm = 4
            star1IsSelect = true
            star2IsSelect = true
            star3IsSelect = true
            
            starOutlet1.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet2.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet3.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet4.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        print (noteFilm)
    }
    @IBAction func star5(_ sender: Any) {
        
        star5IsSelect.toggle()
        if star5IsSelect == false {
            starOutlet5.setImage(UIImage(systemName: "star"), for: .normal)
            noteFilm = 4
            
        }
        else {
            noteFilm = 5
            
            star1IsSelect = true
            star2IsSelect = true
            star3IsSelect = true
            star4IsSelect = true
            
            starOutlet1.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet2.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet3.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet4.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet5.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        print (noteFilm)
    }
    
  
}
