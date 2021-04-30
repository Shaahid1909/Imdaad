//
//  SupervisorTechWkCell.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 25/04/21.
//

import UIKit

class SupervisorTechWkCell: UITableViewCell {

    @IBOutlet weak var TlayerView: UIView!
    @IBOutlet weak var TwktypTokenlab: UILabel!
    @IBOutlet weak var Twktype: UILabel!
    @IBOutlet weak var Tdateandtimelab: UILabel!
    @IBOutlet weak var Tlocationlab: UILabel!
    @IBOutlet weak var statusview: UIView!
    @IBOutlet weak var statustokenlab: UILabel!
    @IBOutlet weak var ishighprioritylab: UILabel!
    
    @IBOutlet weak var alertImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        TlayerView.layer.masksToBounds = false
        TlayerView.layer.shadowRadius = 4
        TlayerView.layer.shadowOpacity = 1
        TlayerView.layer.shadowColor = UIColor.gray.cgColor
        TlayerView.layer.shadowOffset = CGSize(width: 0 , height:6)
        
        
       
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
