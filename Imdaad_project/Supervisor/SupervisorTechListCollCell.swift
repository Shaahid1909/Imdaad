//
//  SupervisorTechListCollCell.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 25/04/21.
//

import UIKit

class SupervisorTechListCollCell: UICollectionViewCell {
    
    
    @IBOutlet weak var layview: UIView!
    @IBOutlet weak var namelab: UILabel!
    
    @IBOutlet weak var ImgView: UIImageView!
    @IBOutlet weak var countlab: UILabel!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layview.layer.masksToBounds = false
        layview.layer.shadowRadius = 4
        layview.layer.shadowOpacity = 1
        layview.layer.shadowColor = UIColor.gray.cgColor
        layview.layer.shadowOffset = CGSize(width: 0 , height:6)
        
    }


    

    
}
