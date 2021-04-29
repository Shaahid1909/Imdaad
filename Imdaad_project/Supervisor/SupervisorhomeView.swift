//
//  SupervisorhomeView.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 24/04/21.
//

import UIKit

class SupervisorhomeView: UIViewController {
    
    
    
    @IBOutlet weak var wkbtn: UIButton!
    @IBOutlet weak var unassignbtn: UIButton!
    @IBOutlet weak var fcbtn: UIButton!
    @IBOutlet weak var techbtn: UIButton!
    
    @IBOutlet weak var wkView: UIView!
    @IBOutlet weak var unassignedView: UIView!
    @IBOutlet weak var fieldcompletionView: UIView!
    @IBOutlet weak var technicianView: UIView!
    
    @IBAction func Workorders(_ sender: Any) {
        performSegue(withIdentifier: "workorders", sender: self)
        print("wk tapped")
    }
    
    @IBAction func UnassignedWorkorders(_ sender: Any) {
        performSegue(withIdentifier: "unassigned", sender: self)
        print("unassigned tapped")
        
    }
    
    @IBAction func FieldCompletion(_ sender: Any) {
        performSegue(withIdentifier: "fieldcompletion", sender: self)
        
        print("fc tapped")
    }
    
    @IBAction func Technicians(_ sender: Any) {
        performSegue(withIdentifier: "technicians", sender: self)
        print("technician tapped")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        wkView.layer.masksToBounds = false
        wkView.layer.shadowRadius = 4
        wkView.layer.shadowOpacity = 1
        wkView.layer.shadowColor = UIColor.gray.cgColor
        wkView.layer.shadowOffset = CGSize(width: 0 , height:6)
        wkView.layer.borderWidth = 0.5
        wkView.layer.borderColor = UIColor.black.cgColor
        wkView.addSubview(wkbtn)
        
        
        unassignedView.layer.masksToBounds = false
        unassignedView.layer.shadowRadius = 4
        unassignedView.layer.shadowOpacity = 1
        unassignedView.layer.shadowColor = UIColor.gray.cgColor
        unassignedView.layer.shadowOffset = CGSize(width: 0 , height:6)
        unassignedView.layer.borderWidth = 0.5
        unassignedView.layer.borderColor = UIColor.black.cgColor
        unassignedView.addSubview(unassignbtn)
        
        fieldcompletionView.layer.masksToBounds = false
        fieldcompletionView.layer.shadowRadius = 4
        fieldcompletionView.layer.shadowOpacity = 1
        fieldcompletionView.layer.shadowColor = UIColor.gray.cgColor
        fieldcompletionView.layer.shadowOffset = CGSize(width: 0 , height:6)
        fieldcompletionView.layer.borderWidth = 0.5
        fieldcompletionView.layer.borderColor = UIColor.black.cgColor
        fieldcompletionView.addSubview(fcbtn)
        
        technicianView.layer.masksToBounds = false
        technicianView.layer.shadowRadius = 4
        technicianView.layer.shadowOpacity = 1
        technicianView.layer.shadowColor = UIColor.gray.cgColor
        technicianView.layer.shadowOffset = CGSize(width: 0 , height:6)
        technicianView.layer.borderWidth = 0.2
        technicianView.layer.borderColor = UIColor.black.cgColor
        technicianView.addSubview(techbtn)
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
