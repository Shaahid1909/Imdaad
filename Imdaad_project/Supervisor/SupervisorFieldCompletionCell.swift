//
//  SupervisorFieldCompletionCell.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 25/04/21.
//

import UIKit

class SupervisorFieldCompletionCell: UITableViewCell {

    @IBOutlet weak var flayerView: UIView!
    @IBOutlet weak var fwktypTokenlab: UILabel!
    @IBOutlet weak var fwktype: UILabel!
    @IBOutlet weak var ftechnicianlab: UILabel!
    @IBOutlet weak var fdateandtimelab: UILabel!
    @IBOutlet weak var flocationlab: UILabel!
   
    @IBOutlet weak var statusview: UIView!
    @IBOutlet weak var statustokenlab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        flayerView.layer.masksToBounds = false
        flayerView.layer.shadowRadius = 4
        flayerView.layer.shadowOpacity = 1
        flayerView.layer.shadowColor = UIColor.gray.cgColor
        flayerView.layer.shadowOffset = CGSize(width: 0 , height:6)
        
        statusview.translatesAutoresizingMaskIntoConstraints = false
        statustokenlab.translatesAutoresizingMaskIntoConstraints = false
        statusview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        statusview.topAnchor.constraint(equalTo: contentView.topAnchor)
        statustokenlab.leadingAnchor.constraint(equalTo: statusview.leadingAnchor)
        statustokenlab.trailingAnchor.constraint(equalTo: statusview.trailingAnchor)
        statustokenlab.topAnchor.constraint(equalTo: statusview.topAnchor)
        statustokenlab.bottomAnchor.constraint(equalTo: statusview.bottomAnchor)
        
 
        statustokenlab.backgroundColor = #colorLiteral(red: 0.8869355321, green: 0.9696996808, blue: 0.8469731212, alpha: 1)
        statustokenlab.textColor = #colorLiteral(red: 0.3037118316, green: 0.4785143137, blue: 0.2119479775, alpha: 1)
        statusview.backgroundColor = #colorLiteral(red: 0.8869355321, green: 0.9696996808, blue: 0.8469731212, alpha: 1)
        statustokenlab.text = "Field Complete"
           
           
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
