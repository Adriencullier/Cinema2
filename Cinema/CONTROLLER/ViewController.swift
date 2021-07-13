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
    
    
    var arrayOfFilms = [Film]()
    var sortedArrayOfFilms  = [Film]()
    var arrayOfDate = [String]()
    var sortedArrayOfDate = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FilmService.shared.getFilmsRelease { success, arrayOfFilm in
            if success, let arrayOfFilm = arrayOfFilm {
                for element in arrayOfFilm.results {
                    self.arrayOfFilms.append(element)
                    if self.arrayOfDate.contains(element.release_date) == false {
                        self.arrayOfDate.append(element.release_date)
                    }
                    else{
                        
                    }
                   
                }
                self.sortedArrayOfFilms = self.arrayOfFilms.sorted{
                    $0.release_date < $1.release_date
                    }
                self.sortedArrayOfDate = self.arrayOfDate.sorted{
                    $0 < $1
                }
            }
            
        }
        
      
        
        let name = Notification.Name(rawValue: "filmsLoaded")
        NotificationCenter.default.addObserver(self, selector: #selector(filmsLoaded), name: name, object: nil)
        
       
        
    }
    
   
    @objc func filmsLoaded(){
        DispatchQueue.main.async {
            self.filmCollectionView.reloadData()
    }
        DispatchQueue.main.async {
            self.dateCollectionView.reloadData()
        }
        
    }
    
  
   
        
    }



extension ViewController : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == filmCollectionView {
        return self.sortedArrayOfFilms.count
        }
        else {
          return  self.sortedArrayOfDate.count
        }
     
    }
   
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cellFilm = filmCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CustomCollectionViewCell
        
        cellFilm.labelCell.text = sortedArrayOfFilms[indexPath.item].title
        cellFilm.labelDateCell.text = sortedArrayOfFilms[indexPath.item].release_date
        cellFilm.imageCell.image = UIImage(data: FilmService.shared.getImage(imagePath: sortedArrayOfFilms[indexPath.item].poster_path))
        
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
    
    
}



extension ViewController : UICollectionViewDelegate {
    
}


    


    
    

    
    



