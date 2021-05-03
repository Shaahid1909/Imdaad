//
//  SupervisorUnassignedVC.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 25/04/21.
//

import UIKit

class SupervisorUnassignedVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
  //  var deptdet = [deptdetails]()
    var unwkorder = [unworkorderData]()
    var unemp_id: String?
    var urlpath:String?
 //   var unassignC = [unccount]()
    
    
    @IBOutlet weak var untabView: UITableView!
    
    @IBOutlet weak var filterVieww: UIView!
    
    @IBOutlet weak var totalworkorders: UILabel!
    
    @IBAction func exitBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.removeSpinner()
    }
    //    override func viewWillAppear(_ animated: Bool) {
//
//        wkorder.removeAll()
//        downloadItems()
//        tabView.reloadData()
//
//    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadItems()
      // uncountdownloadItems()
   //     deptdownloadItems()
        untabView.reloadData()
        untabView.delegate = self
        untabView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        totalworkorders.text = "\(unwkorder.count)"
        return unwkorder.count
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

        let cell = tableView.dequeueReusableCell(withIdentifier: "unwkorder", for: indexPath) as! SupervisorUnassignedCell
      
        
        cell.unwktypTokenlab.text = unwkorder[indexPath.row].unworktypetoken
        cell.unwktype.text = unwkorder[indexPath.row].unWorktype
        cell.undateandtimelab.text = unwkorder[indexPath.row].unDatetime
        cell.unlocationlab.text = unwkorder[indexPath.row].unlocation
        
        
                return cell
            
        
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "reassignwkdetail", sender: self)
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "workorderdetail") as! SupervisorHomeVc
//
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "reassignwkdetail" {
            if segue.destination is SupervisorReassignWKdetail {
                    if let indexPath = untabView.indexPathForSelectedRow {
                        UserDefaults.standard.set(unwkorder[indexPath.row].unworktypetoken, forKey: "token_id")
                      
                    }
                }
            }
        
    }
    
  
    
    func downloadItems() {
        guard let employee_id = UserDefaults.standard.value(forKey: "employee_id") as? String else {return}


        let request = NSMutableURLRequest(url: NSURL(string: urlpath ?? "https://appstudio.co/iOS/imdaad_supervisor_retrieve.php")! as URL)
            request.httpMethod = "POST"
            let postString = "employee_id=\(employee_id)"
            print("postString \(postString)")
            request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
              data, response, error in
              if error != nil {
                print("error=\(String(describing: error))")
                return
              }
              self.parseJSON(data!)
              print("response = \(String(describing: response))")
              let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
              print("responseString = \(String(describing: responseString))")
            }
            task.resume()

            }

    
    func parseJSON(_ data:Data) {
        var jsonResult = NSArray()
            do{
                jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            } catch let error as NSError {
                print(error)
            }
            var jsonElement = NSDictionary()
        let stocks = NSMutableArray()
        for i in 0 ..< jsonResult.count
             {
            jsonElement = jsonResult[i] as! NSDictionary
                //the following insures none of the JsonElement values are nil through optional binding
            if jsonElement["status_token"] as! String == "unassign"{
            unwkorder.append(unworkorderData(unworktypetoken: jsonElement["work_type_token"] as? String, unWorktype: jsonElement["work_type"] as? String, unDatetime: jsonElement["date_time"] as? String, unlocation: jsonElement["location"] as? String, unpriority: jsonElement["is_high_priority"] as? String, unworkorder: jsonElement["work_order_count"] as? String))
                
                
            }}
        DispatchQueue.main.async(execute: { [self] () -> Void in
            self.untabView.reloadData()
        })
        }



}
struct unworkorderData {
var unworktypetoken:String?
var unWorktype:String?
var unDatetime: String?
var unlocation: String?
    var unpriority: String?
    var unworkorder: String?
}

//struct deptdetails{
//    var detpartment: String?
//}
//struct unccount{
//    var unassigncount: String?
//
//}
