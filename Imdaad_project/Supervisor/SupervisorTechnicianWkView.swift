//
//  SupervisorTechnicianWkView.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 25/04/21.
//

import UIKit

class SupervisorTechnicianWkView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var name: String?
    var work_counts:String?
    var Twkorder = [TworkorderData]()
    var Temp_id: String?
    var urlpath:String?
    var id: String?
    @IBOutlet weak var workordercount: UILabel!
    
    @IBOutlet weak var namelab: UILabel!
    @IBOutlet weak var TtabView: UITableView!
    
    @IBOutlet weak var TfilterVieww: UIView!
    @IBOutlet weak var totalcount: UILabel!
    
    @IBAction func exitBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

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
        TtabView.reloadData()
        TtabView.delegate = self
        TtabView.dataSource = self
        
        namelab.text = name
        workordercount.text = work_counts
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 188
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        totalcount.text = "\(Twkorder.count)"
        return Twkorder.count
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
//        if AssignWkList[indexPath.row].priority == "0"{
//        cell.prioritylab.text = ""
//        cell.alertImg.image = UIImage(named: "")
//        }else{
//        cell.prioritylab.text = "High Priority"
//        cell.alertImg.image = UIImage(named: "alert")
//        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Twkorder", for: indexPath) as! SupervisorTechWkCell

        if Twkorder[indexPath.row].is_highpriority == "0"{
        cell.ishighprioritylab.text = ""
        cell.alertImg.image = UIImage(named: "")
        }else{
        cell.ishighprioritylab.text = "High Priority"
        cell.alertImg.image = UIImage(named: "alert")
        }
        cell.TwktypTokenlab.text = Twkorder[indexPath.row].Tworktypetoken
        cell.Twktype.text = Twkorder[indexPath.row].TWorktype
        cell.Tdateandtimelab.text = Twkorder[indexPath.row].TDatetime
        cell.Tlocationlab.text = Twkorder[indexPath.row].Tlocation
        if Twkorder[indexPath.row].statusToken == "Completed"{
            cell.statustokenlab.backgroundColor = #colorLiteral(red: 0.8869355321, green: 0.9696996808, blue: 0.8469731212, alpha: 1)
            cell.statustokenlab.textColor = #colorLiteral(red: 0.3037118316, green: 0.4785143137, blue: 0.2119479775, alpha: 1)
            cell.statusview.backgroundColor = #colorLiteral(red: 0.8869355321, green: 0.9696996808, blue: 0.8469731212, alpha: 1)
           
            cell.statustokenlab.text = Twkorder[indexPath.row].statusToken
            return cell
        }else{
            cell.statustokenlab.backgroundColor = #colorLiteral(red: 0.9433307052, green: 0.9564425349, blue: 0.9688840508, alpha: 1)
            cell.statustokenlab.textColor = #colorLiteral(red: 0.1106616929, green: 0.3126315475, blue: 0.5071651936, alpha: 1)
            cell.statusview.backgroundColor = #colorLiteral(red: 0.9433307052, green: 0.9564425349, blue: 0.9688840508, alpha: 1)
            cell.statustokenlab.text = Twkorder[indexPath.row].statusToken
            return cell
        }
        return UITableViewCell()
  
    }

    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        performSegue(withIdentifier: "workorderdetail", sender: self)
//
//    }
    
  
    
    func downloadItems() {
        guard let employee_id = UserDefaults.standard.value(forKey: "employee_id") as? String else {return}
        
        let request = NSMutableURLRequest(url: NSURL(string:"https://appstudio.co/iOS/Imdaad_Particular_technician_details.php")! as URL)
            request.httpMethod = "POST"
            let postString = "employee_id=\(id!)"
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
                //the following insures none of the JsonElement values are nil through optional binding
         
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
//            let datetime = formatter.date(from: "\(jsonElement["TaskDate"] as! String) 13:37:00 +0100")
//            let dateformatter = DateFormatter()
//            dateformatter.dateFormat = "E,d MMM"
//            let datetostring = dateformatter.string(from: datetime!)
//            print("datetime \(datetime) \(jsonElement["TaskDate"] as? String) \(datetostring)")
            
            Twkorder.append(TworkorderData(Tworktypetoken: jsonElement["work_type_token"] as? String, TWorktype: jsonElement["work_type"] as? String, TDatetime: jsonElement["date_time"] as? String, Tlocation: jsonElement["location"] as? String, statusToken: jsonElement["status_token"] as? String, is_highpriority: jsonElement["is_high_priority"] as? String))
                
                
            }
        DispatchQueue.main.async(execute: { [self] () -> Void in
            itemsDownloaded(items: stocks)
        })
        }
    func itemsDownloaded(items: NSArray) {
       
        self.TtabView.reloadData()
      }
    


    

}
struct TworkorderData {
var Tworktypetoken:String?
var TWorktype:String?
var TDatetime: String?
var Tlocation: String?
var statusToken: String?
var is_highpriority: String?

}

