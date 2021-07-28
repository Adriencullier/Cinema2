//
//  ViewController.swift
//  Cinema
//
//  Created by Adrien Cullier on 08/07/2021.
//

import UIKit

class ViewFilmsViewController: UIViewController {
    

    @IBOutlet weak var filmCollectionView: UICollectionView!
    

    
    var arrayOfFilms = Set<Film>()
    var arrayOfDate = [String]()
    var sortedArrayOfDate = [String]()
    var sortedFilmDBTot = [FilmDB]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmCollectionView.reloadData()

        print(getViewFilms().count)
        
    }
    @IBAction func unwindViewFilmController(segue:UIStoryboardSegue) {
        filmCollectionView.reloadData()
    }

   
}



extension ViewFilmsViewController : UICollectionViewDataSource {

  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return getViewFilms().count
        
     
    }
   
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cellFilm = filmCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CustomCollectionViewCell
        
        cellFilm.labelCell.text = getViewFilms()[indexPath.item].title




        
        let image = getImage(imagePath: getViewFilms()[indexPath.item].poster_path!)

        let data = image.jpegData(compressionQuality: 0)

        cellFilm.imageCell.image = UIImage(data: data!)
        
        if getViewFilms()[indexPath.item].noteFilm == 0 {
            cellFilm.star1Outlet.setImage(UIImage(systemName: "star"), for: .normal)
            cellFilm.star2Outlet.setImage(UIImage(systemName: "star"), for: .normal)
            cellFilm.star3Outlet.setImage(UIImage(systemName: "star"), for: .normal)
            cellFilm.star4Outlet.setImage(UIImage(systemName: "star"), for: .normal)
            cellFilm.star5Outlet.setImage(UIImage(systemName: "star"), for: .normal)
        }
        else if getViewFilms()[indexPath.item].noteFilm == 1 {
            cellFilm.star1Outlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cellFilm.star2Outlet.setImage(UIImage(systemName: "star"), for: .normal)
            cellFilm.star3Outlet.setImage(UIImage(systemName: "star"), for: .normal)
            cellFilm.star4Outlet.setImage(UIImage(systemName: "star"), for: .normal)
            cellFilm.star5Outlet.setImage(UIImage(systemName: "star"), for: .normal)
        }
        else if getViewFilms()[indexPath.item].noteFilm == 2 {
            cellFilm.star1Outlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cellFilm.star2Outlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cellFilm.star3Outlet.setImage(UIImage(systemName: "star"), for: .normal)
            cellFilm.star4Outlet.setImage(UIImage(systemName: "star"), for: .normal)
            cellFilm.star5Outlet.setImage(UIImage(systemName: "star"), for: .normal)
        }
        else if getViewFilms()[indexPath.item].noteFilm == 3 {
            cellFilm.star1Outlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cellFilm.star2Outlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cellFilm.star3Outlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cellFilm.star4Outlet.setImage(UIImage(systemName: "star"), for: .normal)
            cellFilm.star5Outlet.setImage(UIImage(systemName: "star"), for: .normal)
        }
        else if getViewFilms()[indexPath.item].noteFilm == 4 {
            cellFilm.star1Outlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cellFilm.star2Outlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cellFilm.star3Outlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cellFilm.star4Outlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cellFilm.star5Outlet.setImage(UIImage(systemName: "star"), for: .normal)
        }
        else if getViewFilms()[indexPath.item].noteFilm == 5 {
            cellFilm.star1Outlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cellFilm.star2Outlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cellFilm.star3Outlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cellFilm.star4Outlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cellFilm.star5Outlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        else{}

        return cellFilm
    }

    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let sectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectioHeaderView", for: indexPath) as! SectionViewHeaderCollectionReusableView
//
//        sectionViewHeader.sectionHeaderLabel.text = "Sortie le  \(getDate(dateString: getSectionArray()[indexPath.section]))"
//
//
//        return sectionViewHeader
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(getViewFilms()[indexPath.item].title!)
        let filmDic2 = [
            "title" : getViewFilms()[indexPath.item].title! ,
            "description" : getViewFilms()[indexPath.item].overview!,
            "releaseDate" : getViewFilms()[indexPath.item].original_language!,
            "filmId" : String(getViewFilms()[indexPath.item].filmId),
            "noteFilm" : getViewFilms()[indexPath.item].noteFilm
        ] as [String : Any]

        UserDefaults.standard.set(filmDic2, forKey: "currentFilm2")
       
    }
}
 
    


        



extension ViewFilmsViewController : UICollectionViewDelegate {
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        getSectionArray().count
//    }
//
}




    


    
    

    
    



