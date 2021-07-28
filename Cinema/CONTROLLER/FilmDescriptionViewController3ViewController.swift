//
//  FilmDescriptionViewController2ViewController.swift
//  Cinema
//
//  Created by Adrien Cullier on 20/07/2021.
//

import UIKit
import WebKit

class FilmDescriptionViewController3ViewController: UIViewController {
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
        
        releaseDateLabel.text = "Sortie en salle : \(getDate(dateString: film!["releaseDate"] as! String) as? String)"
        languageLabel.text = "Langue originale : \"\(film!["originalLanguage"] ?? "")\""
        if film!["noteFilm"] as! Int == 0 {
            noteFilm = 0
            star1IsSelect = false
            star2IsSelect = false
            star3IsSelect = false
            star4IsSelect = false
            star5IsSelect = false
            starOutlet1.setImage(UIImage(systemName: "star"), for: .normal)
            starOutlet2.setImage(UIImage(systemName: "star"), for: .normal)
            starOutlet3.setImage(UIImage(systemName: "star"), for: .normal)
            starOutlet4.setImage(UIImage(systemName: "star"), for: .normal)
            starOutlet5.setImage(UIImage(systemName: "star"), for: .normal)
        }
        else if film!["noteFilm"] as! Int == 1 {
            noteFilm = 1
            star1IsSelect = true
            star2IsSelect = false
            star3IsSelect = false
            star4IsSelect = false
            star5IsSelect = false
            starOutlet1.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet2.setImage(UIImage(systemName: "star"), for: .normal)
            starOutlet3.setImage(UIImage(systemName: "star"), for: .normal)
            starOutlet4.setImage(UIImage(systemName: "star"), for: .normal)
            starOutlet5.setImage(UIImage(systemName: "star"), for: .normal)
        }
        else if film!["noteFilm"] as! Int == 2 {
            noteFilm = 2
            star1IsSelect = true
            star2IsSelect = true
            star3IsSelect = false
            star4IsSelect = false
            star5IsSelect = false
            starOutlet1.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet2.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet3.setImage(UIImage(systemName: "star"), for: .normal)
            starOutlet4.setImage(UIImage(systemName: "star"), for: .normal)
            starOutlet5.setImage(UIImage(systemName: "star"), for: .normal)
        }
        else if film!["noteFilm"] as! Int == 3 {
            noteFilm = 3
            star1IsSelect = true
            star2IsSelect = true
            star3IsSelect = true
            star4IsSelect = false
            star5IsSelect = false
            starOutlet1.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet2.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet3.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet4.setImage(UIImage(systemName: "star"), for: .normal)
            starOutlet5.setImage(UIImage(systemName: "star"), for: .normal)
        }
        else if film!["noteFilm"] as! Int == 4 {
            noteFilm = 4
            star1IsSelect = true
            star2IsSelect = true
            star3IsSelect = true
            star4IsSelect = true
            star5IsSelect = false
            starOutlet1.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet2.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet3.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet4.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet5.setImage(UIImage(systemName: "star"), for: .normal)
        }
        else if film!["noteFilm"] as! Int ==  5 {
            noteFilm = 5
            star1IsSelect = true
            star2IsSelect = true
            star3IsSelect = true
            star4IsSelect = true
            star5IsSelect = true
            starOutlet1.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet2.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet3.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet4.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starOutlet5.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        else{}
        
        FilmService.shared.getTrailer(filmId: film!["filmId"] as! String) { success, key in
            if success {
//                print(film?["filmId"])
                self.key2 = key
//                print ("Key 2 : \(self.key2)")
            }
            else {
                print(film?["filmId"]!)
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

    

    
//    @IBAction func deleteButton(_ sender: Any) {
//
//        let film = UserDefaults.standard.object(forKey: "currentFilm2") as? [String:String]
//        deleteFromFavorite(filmTitle: film!["title"] ?? "")
//
//        }
        
    
    
    @IBAction func updateButton(_ sender: Any) {
        let film = UserDefaults.standard.object(forKey: "currentFilm2") as? [String:Any]
        isView(filmTitle: film!["title"] as? String ?? "", noteFilm: Int64(noteFilm))
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
