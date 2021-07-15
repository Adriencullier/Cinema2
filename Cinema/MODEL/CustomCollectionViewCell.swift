//
//  CustomCollectionViewCell.swift
//  Cinema
//
//  Created by Adrien Cullier on 09/07/2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var labelCell: UILabel!
    
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    override func awakeFromNib() {
            super.awakeFromNib()
//
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        
        
        }
    
    
    @IBAction func favoriteButton(_ sender: Any) {
    }
    
    @IBAction func filmButton(_ sender: Any) {
        print("Caca")
    }
    
    func configureCell (filmCell : Film) {
//        labelCell.text = "TEST"
    }
    
}
