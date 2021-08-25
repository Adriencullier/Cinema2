//
//  CustomCollectionViewCell.swift
//  Cinema
//
//  Created by Adrien Cullier on 09/07/2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var star1Outlet: UIButton!
    
    @IBOutlet weak var star2Outlet: UIButton!
    @IBOutlet weak var star3Outlet: UIButton!
    @IBOutlet weak var star4Outlet: UIButton!
    
    @IBOutlet weak var star5Outlet: UIButton!
    

    @IBOutlet weak var labelCell: UILabel!
    
    @IBOutlet weak var imageCell: UIImageView!
    
  
    override func awakeFromNib() {
            super.awakeFromNib()

        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        
        
        }
    
    

    
   
    
   
}


