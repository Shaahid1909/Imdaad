//
//  supervisorNotifiCell.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 25/04/21.
//

import UIKit

class supervisorNotifiCell: UITableViewCell {
    
    
    @IBOutlet weak var datelab: UILabel!
    
    @IBOutlet weak var titlelab: UILabel!
    
    @IBOutlet weak var msglab: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
