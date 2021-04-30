//
//  SupervisorUnassignedCell.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 25/04/21.
//

import UIKit

class SupervisorUnassignedCell: UITableViewCell {

    @IBOutlet weak var unlayerView: UIView!
    @IBOutlet weak var unwktypTokenlab: UILabel!
    @IBOutlet weak var unwktype: UILabel!
    @IBOutlet weak var undateandtimelab: UILabel!
    @IBOutlet weak var unlocationlab: UILabel!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        unlayerView.layer.masksToBounds = false
        unlayerView.layer.shadowRadius = 4
        unlayerView.layer.shadowOpacity = 1
        unlayerView.layer.shadowColor = UIColor.gray.cgColor
        unlayerView.layer.shadowOffset = CGSize(width: 0 , height:6)
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
