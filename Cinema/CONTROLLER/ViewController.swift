//
//  ViewController.swift
//  Cinema
//
//  Created by Adrien Cullier on 08/07/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var filmCollectionView: UICollectionView!
    
    @IBOutlet weak var dateCollectionView: UICollectionView!
    
    
    var arrayOfFilms = Set<Film>()
    var arrayOfDate = [String]()
    var sortedArrayOfDate = [String]()
    var sortedFilmDBTot = [FilmDB]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        displayFavoriteFilm()
//
        FilmService.shared.getFilmsRelease { success, arrayOfFilm in
            if success, let arrayOfFilm = arrayOfFilm {
                for element in arrayOfFilm.results {
                    
                    self.arrayOfFilms.insert(element)
                    print (self.arrayOfFilms.description)
//                    saveFilm(film: element)
//                    deleteAllFilms()
                    if self.arrayOfDate.contains(element.release_date) == false {
                        self.arrayOfDate.append(element.release_date)
                    }
                    else{
                    }
                }
                
                for element in arrayOfFilms {
                    if
                }
                
            }
        }

        let name = Notification.Name(rawValue: "filmsLoaded")
        NotificationCenter.default.addObserver(self, selector: #selector(filmsLoaded), name: name, object: nil)
        
       
        
    }
    

    
    @objc func filmsLoaded(){
        DispatchQueue.main.async {
            self.filmCollectionView.reloadData()
//            displayFavoriteFilm()
            
            self.sortedFilmDBTot = FilmDB.all.sorted{
              $0.release_date ?? "" < $1.release_date ?? ""
            }
            self.sortedArrayOfDate = self.arrayOfDate.sorted{
                $0 < $1
            }
            
            
            
    }
        DispatchQueue.main.async {
            self.dateCollectionView.reloadData()
        }
        
    }
    
  
   
        
    }



extension ViewController : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == filmCollectionView {
            return FilmDB.all.count
        }
        else {
          return  sortedArrayOfDate.count
        }
     
    }
   
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cellFilm = filmCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CustomCollectionViewCell
        
        cellFilm.labelCell.text = FilmDB.all[indexPath.item].title
        
        cellFilm.favoriteButtonOutlet.tag = indexPath.item
            
        cellFilm.favoriteButtonOutlet.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
       
        let image = UIImage(data: (getImage(imagePath: FilmDB.all[indexPath.item].poster_path ?? "")))
        
        let data = image?.jpegData(compressionQuality: -15)
        
        cellFilm.imageCell.image = UIImage(data: data ?? Data(count: 0))
        
        let cellDate = dateCollectionView.dequeueReusableCell(withReuseIdentifier: "DateCustomCollectionViewCell", for: indexPath) as! DateCustomCollectionViewCell
        
        if indexPath.item <= sortedArrayOfDate.count-1 {
            
            cellDate.labelDateCV.text = FilmService.shared.getDate(dateString: self.sortedArrayOfDate[indexPath.item])
            
        }
        
        if collectionView == filmCollectionView{
        return cellFilm
        }
        else {
            return cellDate
        }
        
    }
 
    @objc func addToFavorite(sender : UIButton){
        
        for element in FilmDB.all{
            if element.title == sortedFilmDBTot[sender.tag].title && FilmDB.all[sender.tag].isFavorite == false  {
                element.isFavorite = true
                sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
            else if element.title == FilmDB.all[sender.tag].title && FilmDB.all[sender.tag].isFavorite == true  {
                element.isFavorite = false
                sender.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            
        }
        print(sortedFilmDBTot[sender.tag].title ?? "", FilmDB.all[sender.tag].isFavorite )
    }
    
}



extension ViewController : UICollectionViewDelegate {
    
}




    


    
    

    
    



