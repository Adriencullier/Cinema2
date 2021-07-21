//
//  TinderViewController.swift
//  Cinema
//
//  Created by Adrien Cullier on 15/07/2021.
//

import UIKit

class TinderViewController: UIViewController {
    var arrayOfFilms = Set<Film>()
    var sortedFilmDBTot = [FilmDB]()
    var randomFilm = FilmDB()

    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    @IBOutlet weak var infoButtonOutlet: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterLabel: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    
    @IBAction func favoriteButton(_ sender: Any) {
        
        addToFavorite(film: randomFilm)
        configureView()
    }
        
        
        
        
    
    @IBAction func deleteButton(_ sender: Any) {
        
       deleteFilm(film: randomFilm)
        configureView()

       
    }
    
       
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      

        FilmService.shared.getFilmsRelease { success, arrayOfFilm in
            if success, let arrayOfFilm = arrayOfFilm {
                for element in arrayOfFilm.results {
                    
                    self.arrayOfFilms.insert(element)
                }
                for element in self.arrayOfFilms {
                    print (element.title)
                }
            }
        }
        
        let name = Notification.Name(rawValue: "filmsLoaded")
        NotificationCenter.default.addObserver(self, selector: #selector(filmsLoaded), name: name, object: nil)
    }
 
    
    
    @objc func filmsLoaded(){
//        deleteAllFilms()
        saveFilm(filmArray: self.arrayOfFilms)
        print (self.sortedFilmDBTot.count)
        
        self.sortedFilmDBTot = FilmDB.all.sorted{
            $0.release_date ?? "" < $1.release_date ?? ""
        }
        
        for element in self.sortedFilmDBTot {
            print ("XXX \(element.title!), \(element.isFavorite), isView : \(element.isView)")
        }
 
        
        configureView ()

        
        
    }
    func configureView () {

        randomFilm = displayRandomFilm(filmArray: sortedFilmDBTot)
        
        let filmDic = [
            "title" : randomFilm.title ?? "",
            "description" : randomFilm.overview ?? "",
            "releaseDate" : randomFilm.release_date ?? "",
            "originalLanguage" :randomFilm.original_language ?? "",
            "filmId" : String(randomFilm.filmId) 
        ]
        print("filmId userdefault : \(String(randomFilm.filmId))")
        
        UserDefaults.standard.set(filmDic, forKey: "currentFilm")
        if randomFilm.title != "Plus de films..."{
        titleLabel.text = randomFilm.title
        releaseDateLabel.text = "Sortie en salle : \(getDate(dateString: randomFilm.release_date!))"
        let image = getImage(imagePath: randomFilm.poster_path ?? "errorImage")
        let data = image.jpegData(compressionQuality: 0)
            posterLabel.image = UIImage(data: data ?? Data(count: 1))}
        
        else {
            titleLabel.text = "Plus de films..."
            releaseDateLabel.text = "Vivement mercredi !"
            posterLabel.image = UIImage(named: "error4")
            favoriteButtonOutlet.isHidden = true
            deleteButtonOutlet.isHidden = true
            infoButtonOutlet.isHidden = true
            
            
        }
        
      
       
        
 
    }
    

    
    
}


