//
//  TechWorkorderDetail.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 24/04/21.
//

import UIKit

class TechWorkorderDetail: UIViewController {
    
    
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var sgTextOnlyBar: WMSegment!
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func segmentValueChange(_ sender: WMSegment) {
        print("selected index = \(sender.selectedSegmentIndex)")
        switch sender.selectedSegmentIndex {
        case 0:
            detailView.alpha = 1
            print("first item")
        case 1:
            detailView.alpha = 0
         
            print("second item")
        case 2:
            detailView.alpha = 0
            
            print("Third item")
        default:
            print("default item")
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        sgTextOnlyBar.selectorType = .bottomBar
       sgTextOnlyBar.SelectedFont = UIFont(name: "ChalkboardSE-Bold", size: 15)!
        sgTextOnlyBar.normalFont = UIFont(name: "ChalkboardSE-Regular", size: 15)!
        dropView.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func dropdownTapped(_ sender: Any) {
        if dropView.isHidden == false{
            dropView.isHidden = true
        }else if dropView.isHidden == true{
            dropView.isHidden = false
        }
    }
  
}
