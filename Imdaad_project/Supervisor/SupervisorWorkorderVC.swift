//
//  SupervisorWorkorderVC.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 25/04/21.
//

import UIKit

class SupervisorWorkorderVC: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    var Swkorder = [SworkorderData]()
    var Semp_id: String?
    var urlpath:String?
    @IBOutlet weak var totalworkorders: UILabel!
    
    @IBOutlet weak var stabView: UITableView!
    
    @IBOutlet weak var filterVieww: UIView!
    
    
    
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
        stabView.reloadData()
        stabView.delegate = self
        stabView.dataSource = self
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 214
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Swkorder.count
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "supwkorder", for: indexPath) as! SupervisorWorkorderCell
        if Swkorder[indexPath.row].priority == "0"{
        cell.prioritylab.text = ""
        cell.alertImg.image = UIImage(named: "")
        }else{
        cell.prioritylab.text = "High Priority"
        cell.alertImg.image = UIImage(named: "alert")
        }
        cell.SwktypTokenlab.text = Swkorder[indexPath.row].worktypetoken
        cell.Swktype.text = Swkorder[indexPath.row].worktypetoken
        cell.Stechnicianlab.text = Swkorder[indexPath.row].technician
        cell.Sdateandtimelab.text = Swkorder[indexPath.row].Datetime
        cell.Slocationlab.text = Swkorder[indexPath.row].location
        totalworkorders.text =  Swkorder[indexPath.row].workorder
        if Swkorder[indexPath.row].statustoken == "Completed"{
            cell.statustokenlab.backgroundColor = #colorLiteral(red: 0.8869355321, green: 0.9696996808, blue: 0.8469731212, alpha: 1)
            cell.statustokenlab.textColor = #colorLiteral(red: 0.3037118316, green: 0.4785143137, blue: 0.2119479775, alpha: 1)
            cell.statusview.backgroundColor = #colorLiteral(red: 0.8869355321, green: 0.9696996808, blue: 0.8469731212, alpha: 1)
            cell.statustokenlab.text = Swkorder[indexPath.row].statustoken
            return cell
        }else{
            cell.statustokenlab.backgroundColor = #colorLiteral(red: 0.9433307052, green: 0.9564425349, blue: 0.9688840508, alpha: 1)
            cell.statustokenlab.textColor = #colorLiteral(red: 0.1106616929, green: 0.3126315475, blue: 0.5071651936, alpha: 1)
            cell.statusview.backgroundColor = #colorLiteral(red: 0.9433307052, green: 0.9564425349, blue: 0.9688840508, alpha: 1)
            cell.statustokenlab.text = Swkorder[indexPath.row].statustoken
            return cell
        }
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "wkdetail", sender: self)
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "workorderdetail") as! SupervisorHomeVc
//
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "wkdetail" {
            if segue.destination is SupervisorWkdetailView {
                    if let indexPath = stabView.indexPathForSelectedRow {
                        UserDefaults.standard.set(Swkorder[indexPath.row].worktypetoken, forKey: "token_id")
                      
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
            print("The count is \(jsonResult.count)")
            jsonElement = jsonResult[i] as! NSDictionary
             
            Swkorder.append(SworkorderData(worktypetoken: jsonElement["work_type_token"] as? String, Worktype: jsonElement["work_type"] as? String, technician: jsonElement["technician_name"] as? String, Datetime: jsonElement["date_time"] as? String, location: jsonElement["location"] as? String, priority: jsonElement["is_high_priority"] as? String, workorder: jsonElement["work_order_count"] as? String, statustoken: jsonElement["status_token"] as? String))
            }
        DispatchQueue.main.async(execute: { [self] () -> Void in
            itemsDownloaded(items: stocks)
        })
        }
    func itemsDownloaded(items: NSArray) {
       
        self.stabView.reloadData()
      }
    

    

}
struct SworkorderData {
var worktypetoken:String?
var Worktype:String?
var technician:String?
var Datetime: String?
var location: String?
var priority: String?
var workorder: String?
    var statustoken: String?

}



