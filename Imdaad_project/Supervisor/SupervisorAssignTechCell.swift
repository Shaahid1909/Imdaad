//
//  SupervisorAssignTechCell.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 25/04/21.
//

import UIKit


protocol assigned_tech_names {
    func Assign_names(cell:SupervisorAssignTechCell, didTappedThe button:UIButton?)
}


class SupervisorAssignTechCell: UITableViewCell {
    
    
    @IBOutlet weak var atname: UILabel!
    
    @IBOutlet weak var atkm: UILabel!

    @IBOutlet weak var selectedtickbtn: UIButton!
    
    var CellDelegate:assigned_tech_names!
    var indexPath: IndexPath!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func Selected_tick(_ sender: Any) {
        selectedtickbtn.isSelected = !selectedtickbtn.isSelected
        CellDelegate?.Assign_names(cell: self, didTappedThe: sender as?UIButton)
    }
    

}
