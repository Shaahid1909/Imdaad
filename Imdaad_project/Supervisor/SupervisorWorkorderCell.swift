//
//  SupervisorWorkorderCell.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 25/04/21.
//

import UIKit

class SupervisorWorkorderCell: UITableViewCell {

    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var SwktypTokenlab: UILabel!
    @IBOutlet weak var Swktype: UILabel!
    @IBOutlet weak var Stechnicianlab: UILabel!
    @IBOutlet weak var Sdateandtimelab: UILabel!
    @IBOutlet weak var Slocationlab: UILabel!
    @IBOutlet weak var prioritylab: UILabel!
    @IBOutlet weak var alertImg: UIImageView!
    @IBOutlet weak var statusview: UIView!
    @IBOutlet weak var statustokenlab: UILabel!
    
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layerView.layer.masksToBounds = false
        layerView.layer.shadowRadius = 4
        layerView.layer.shadowOpacity = 1
        layerView.layer.shadowColor = UIColor.gray.cgColor
        layerView.layer.shadowOffset = CGSize(width: 0 , height:6)
        
        statusview.translatesAutoresizingMaskIntoConstraints = false
        statustokenlab.translatesAutoresizingMaskIntoConstraints = false
        statusview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        statusview.topAnchor.constraint(equalTo: contentView.topAnchor)
        statustokenlab.leadingAnchor.constraint(equalTo: statusview.leadingAnchor)
        statustokenlab.trailingAnchor.constraint(equalTo: statusview.trailingAnchor)
        statustokenlab.topAnchor.constraint(equalTo: statusview.topAnchor)
        statustokenlab.bottomAnchor.constraint(equalTo: statusview.bottomAnchor)
        
        
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
