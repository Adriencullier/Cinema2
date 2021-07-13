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
    @IBOutlet weak var labelDateCell: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
//        labelCell.text = "CACA"
        }
    
    func configureCell (filmCell : Film) {
//        labelCell.text = "TEST"
    }
    
}
