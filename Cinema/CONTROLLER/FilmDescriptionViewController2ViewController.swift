//
//  FilmDescriptionViewController2ViewController.swift
//  Cinema
//
//  Created by Adrien Cullier on 20/07/2021.
//

import UIKit

class FilmDescriptionViewController2ViewController: UIViewController {
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
   
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let film = UserDefaults.standard.object(forKey: "currentFilm2") as? [String:String]
        
        titleLabel.text = film!["title"]
        descriptionText.text = film!["description"]
        
        releaseDateLabel.text = "Sortie en salle : \(getDate(dateString: film!["releaseDate"] ?? ""))"
        languageLabel.text = "Langue originale : \"\(film!["originalLanguage"] ?? "")\""

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
