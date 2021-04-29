//
//  NotifyVC.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 24/04/21.
//

import UIKit

class NotifyVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    
   
    @IBOutlet weak var ntable: UITableView!
    @IBAction func backTapped(_ sender: Any) {
        performSegue(withIdentifier: "back", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ntable.delegate = self
        ntable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notification", for: indexPath) as! notifytabCell
        
        return cell
        
    }
    
}
