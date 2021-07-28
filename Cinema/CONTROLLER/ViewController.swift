//
//  ViewController.swift
//  Cinema
//
//  Created by Adrien Cullier on 08/07/2021.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var filmCollectionView: UICollectionView!
    
    
    
    
    var arrayOfFilms = Set<Film>()
    var arrayOfDate = [String]()
    var sortedArrayOfDate = [String]()
    var sortedFilmDBTot = [FilmDB]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmCollectionView.reloadData()

        
        
    }
    @IBAction func unwindToViewController(segue:UIStoryboardSegue) {
        filmCollectionView.reloadData()
    }
}




extension ViewController : UICollectionViewDataSource {

  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return getFavoriteFilm(releaseDate: getSectionArray()[section]).count
        
     
    }
   
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cellFilm = filmCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CustomCollectionViewCell
        
        cellFilm.labelCell.text = getFavoriteFilm( releaseDate: getSectionArray()[indexPath.section])[indexPath.item].title

//        cellFilm.deleteButtonOutlet.tag = indexPath.item
//        cellFilm.deleteButtonOutlet.addTarget(self, action: #selector(deleteFromFavoritList), for: .touchUpInside)
//
//        cellFilm.isViewButtonOutlet.tag = indexPath.item
//        cellFilm.isViewButtonOutlet.addTarget(self, action: #selector(addInIsView), for: .touchUpInside)
//
//        cellFilm.descriptionFilmOutlet.tag = indexPath.item
//        cellFilm.descriptionFilmOutlet.addTarget(self, action: #selector(descriptionFilm), for: .touchUpInside)


        
        let image = getImage(imagePath: getFavoriteFilm(releaseDate: getSectionArray()[indexPath.section])[indexPath.item].poster_path!)

        let data = image.jpegData(compressionQuality: 0)

        cellFilm.imageCell.image = UIImage(data: data!)
        
       

        return cellFilm
    }
//    @objc func deleteFromFavoritList(sender : UIButton){
//
//         getFavoriteFilm2()[sender.tag].isDelete = true
//        getFavoriteFilm2()[sender.tag].isFavorite = false
//        
//        try? AppDelegate.viewContext.save()
//    
//        filmCollectionView.reloadData()
//        
//    }
//    @objc func descriptionFilm(sender : UIButton){
//        for film in getFavoriteFilm2(){
//            print (film.title!)
//        }
//        print(sender.tag)
        
//        
//    }
//    @objc func addInIsView(sender : UIButton){
//
//        getFavoriteFilm2()[sender.tag].isView = true
//        try? AppDelegate.viewContext.save()
//        filmCollectionView.reloadData()
//
//    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectioHeaderView", for: indexPath) as! SectionViewHeaderCollectionReusableView
        
        sectionViewHeader.sectionHeaderLabel.text = "Sortie le  \(getDate(dateString: getSectionArray()[indexPath.section]))"
       
        
        return sectionViewHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(getFavoriteFilm(releaseDate: getSectionArray()[indexPath.section])[indexPath.item].title!)
        let filmDic2 = [
            "title" : getFavoriteFilm(releaseDate: getSectionArray()[indexPath.section])[indexPath.item].title! ,
            "description" : getFavoriteFilm(releaseDate: getSectionArray()[indexPath.section])[indexPath.item].overview!,
            "releaseDate" : getFavoriteFilm(releaseDate: getSectionArray()[indexPath.section])[indexPath.item].original_language!,
            "filmId" : String(getFavoriteFilm(releaseDate: getSectionArray()[indexPath.section])[indexPath.item].filmId)
        ]

        UserDefaults.standard.set(filmDic2, forKey: "currentFilm2")
       
    }
}
 
    


        



extension ViewController : UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        getSectionArray().count
    }
    
}




    


    
    

    
    



