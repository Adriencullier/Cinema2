//
//  ViewController.swift
//  Cinema
//
//  Created by Adrien Cullier on 08/07/2021.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var filmCollectionView: UICollectionView!
    
    @IBAction func descriptionFilm(_ sender: Any) {
        
    }
    
    
    var arrayOfFilms = Set<Film>()
    var arrayOfDate = [String]()
    var sortedArrayOfDate = [String]()
    var sortedFilmDBTot = [FilmDB]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
    }
}



extension ViewController : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        

        return getFavoriteFilm().count ?? 0
        
     
    }
   
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cellFilm = filmCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CustomCollectionViewCell
        
        cellFilm.labelCell.text = getFavoriteFilm()[indexPath.item].title

        cellFilm.deleteButtonOutlet.tag = indexPath.item
        cellFilm.deleteButtonOutlet.addTarget(self, action: #selector(deleteFromFavoritList), for: .touchUpInside)
        
        cellFilm.isViewButtonOutlet.tag = indexPath.item
        cellFilm.isViewButtonOutlet.addTarget(self, action: #selector(addInIsView), for: .touchUpInside)
        
        cellFilm.descriptionFilmOutlet.tag = indexPath.item
        cellFilm.descriptionFilmOutlet.addTarget(self, action: #selector(descriptionFilm), for: .touchUpInside)


        
        let image = getImage(imagePath: getFavoriteFilm()[indexPath.item].poster_path!)

        let data = image.jpegData(compressionQuality: 0)

        cellFilm.imageCell.image = UIImage(data: data!)
        
        cellFilm.releaseDateLabel.text = "Date de sortie : \(getDate(dateString: getFavoriteFilm()[indexPath.item].release_date!))"


        return cellFilm
    }
    @objc func deleteFromFavoritList(sender : UIButton){

        getFavoriteFilm()[sender.tag].isDelete = true
        getFavoriteFilm()[sender.tag].isFavorite = false
        
        try? AppDelegate.viewContext.save()
    
        filmCollectionView.reloadData()
        
    }
    @objc func descriptionFilm(sender : UIButton){
        let filmDic2 = ["title" : getFavoriteFilm()[sender.tag].title!, "description" : getFavoriteFilm()[sender.tag].overview!, "releaseDate" : getFavoriteFilm()[sender.tag].release_date!, "originalLanguage" : getFavoriteFilm()[sender.tag].original_language!]
        
        UserDefaults.standard.set(filmDic2, forKey: "currentFilm2")
       
        
    }
    @objc func addInIsView(sender : UIButton){

        getFavoriteFilm()[sender.tag].isView = true
        try? AppDelegate.viewContext.save()
        filmCollectionView.reloadData()
        
    }
}
 
    


        



extension ViewController : UICollectionViewDelegate {
    
}




    


    
    

    
    



