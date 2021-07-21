//
//  CustomCollectionViewCell.swift
//  Cinema
//
//  Created by Adrien Cullier on 09/07/2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionFilmOutlet: UIButton!
    @IBOutlet weak var isViewButtonOutlet: UIButton!
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    @IBOutlet weak var labelCell: UILabel!
    
    @IBOutlet weak var imageCell: UIImageView!
    
  
    override func awakeFromNib() {
            super.awakeFromNib()
//
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        
        
        }
    
    

    
   
    
   
}


