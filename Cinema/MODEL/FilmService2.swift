//
//  FilmService2.swift
//  Cinema
//
//  Created by Adrien Cullier on 15/07/2021.
//

import Foundation

func displayRandomFilm (filmArray : [FilmDB]) -> FilmDB {
    var noteVoteFilmArray = [FilmDB]()
    var noteVoteFilm = FilmDB()
    for element in filmArray {
        if element.isDelete == false && element.isFavorite == false && element.isView == false {
            noteVoteFilmArray.append(element)
        }
        else {}
    }
    if noteVoteFilmArray.isEmpty {
        noteVoteFilm = FilmDB(context: AppDelegate.viewContext)
        noteVoteFilm.title = "Plus de films..."
        noteVoteFilm.isDelete = false
        noteVoteFilm.isFavorite = false
        noteVoteFilm.original_language = ""
        noteVoteFilm.overview = ""
        noteVoteFilm.poster_path = ""
        noteVoteFilm.release_date = ""
        print("Il n'y a pas de nouveau film, patientez jusqu'à mercredi prochain !")
    }
    else{
        noteVoteFilm = noteVoteFilmArray.randomElement()!
    }
       
    
    return noteVoteFilm
}

func addToFavorite (film : FilmDB){
    film.setValue(true , forKey: "isFavorite")
    print("le film \(film.title)! a bien été ajouté aux favoris. Is Favorite = \(film.isFavorite)!")
    try? AppDelegate.viewContext.save()
}

func deleteFilm (film : FilmDB) {
    film.setValue(true , forKey: "isDelete")
    print("le film \(film.title)! a bien été supprimé. is delete = \(film.isDelete)!")
    try? AppDelegate.viewContext.save()
}

func deleteFromFavorite (filmTitle : String){
    for film in FilmDB.all {
        if film.title == filmTitle {
            film.setValue(false, forKey: "isFavorite")
            film.setValue(true, forKey: "isDelete")
            print("le film \(film.title)! a bien été supprimé. is delete = \(film.isDelete)!")
        }
        else {
          
        }
        try? AppDelegate.viewContext.save()
    }
}

func isView (filmTitle : String, noteFilm : Int64){
    for film in FilmDB.all {
        if film.title == filmTitle {
            film.setValue(true, forKey: "isView")
            film.setValue(noteFilm, forKey: "noteFilm")
            film.setValue(false, forKey: "isFavorite")
            film.setValue(false, forKey: "isDelete")
            print("le film \(film.title)! a bien été ajouté aux films vus. is view = \(film.isView)! Et la note de \(noteFilm) étoile à bien été attribuée")
        }
        else {
        
        }
        try? AppDelegate.viewContext.save()
    }
    
}

func getNoteFilm () {
    
}



