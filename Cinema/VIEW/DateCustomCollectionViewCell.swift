//
//  DateCustomCollectionViewCell.swift
//  Cinema
//
//  Created by Adrien Cullier on 12/07/2021.
//

import UIKit

class DateCustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelDateCV: UILabel!
    @IBOutlet weak var test: UIView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        labelDateCV.baselineAdjustment = .none
        
        
        }
    
}
