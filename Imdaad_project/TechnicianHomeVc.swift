//
//  TechnicianHomeVc.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 23/04/21.
//

import UIKit

class TechnicianHomeVc: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var wkorder = [workorderData]()
    var emp_id: String?
    var urlpath:String?
    
    @IBOutlet weak var tabView: UITableView!
    
    @IBOutlet weak var filterVieww: UIView!
    
    @IBOutlet weak var sgTextOnlyBar: WMSegment!
    
    @IBAction func notificationTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "notify", sender: self)
        
    }
    
    @IBAction func exitBtn(_ sender: Any) {
        performSegue(withIdentifier: "logout", sender: self)
        self.removeSpinner()
    }
    //    override func viewWillAppear(_ animated: Bool) {
//
//        wkorder.removeAll()
//        downloadItems()
//        tabView.reloadData()
//
//    }
    var nSelectedSegmentIndex : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadItems()
        tabView.reloadData()
        tabView.delegate = self
        tabView.dataSource = self
        
        sgTextOnlyBar.selectorType = .bottomBar
       sgTextOnlyBar.SelectedFont = UIFont(name: "ChalkboardSE-Bold", size: 15)!
        sgTextOnlyBar.normalFont = UIFont(name: "ChalkboardSE-Regular", size: 15)!
        
      
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 214
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
//        let selectedIndex = self.sgTextOnlyBar.selectedSegmentIndex
//        switch selectedIndex
//        {
//        case 0:
//               return wkorder.count
//        case 1:
//               return wkorder.count
//        case 2:
//                return wkorder.count
//        //Add other cases here
//        default:
//            return 0
//        }
        if nSelectedSegmentIndex == 1 {
                    return 3
                }
                else {
                    return  3
                    
                }
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
//        let selectedIndex = self.sgTextOnlyBar.selectedSegmentIndex
//        switch selectedIndex
//        {
//        case 0:
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "techwkorder", for: indexPath) as! TechWorkOrderCell
//            cell.wktypTokenlab.text = wkorder[indexPath.row].worktypetoken
//            cell.wktype.text = wkorder[indexPath.row].Worktype
//            cell.supervisorlab.text = wkorder[indexPath.row].supervisor
//            cell.dateandtimelab.text = wkorder[indexPath.row].Datetime
//            cell.locationlab.text = wkorder[indexPath.row].location
//
//
//            return cell
//        case 1:
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "techwkorder", for: indexPath) as! TechWorkOrderCell
//            cell.wktypTokenlab.text = wkorder[indexPath.row].worktypetoken
//            cell.wktype.text = wkorder[indexPath.row].Worktype
//            cell.supervisorlab.text = wkorder[indexPath.row].supervisor
//            cell.dateandtimelab.text = wkorder[indexPath.row].Datetime
//            cell.locationlab.text = wkorder[indexPath.row].location
//
//
//            return cell
//        case 2:
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "techwkorder", for: indexPath) as! TechWorkOrderCell
//            cell.wktypTokenlab.text = wkorder[indexPath.row].worktypetoken
//            cell.wktype.text = wkorder[indexPath.row].Worktype
//            cell.supervisorlab.text = wkorder[indexPath.row].supervisor
//            cell.dateandtimelab.text = wkorder[indexPath.row].Datetime
//            cell.locationlab.text = wkorder[indexPath.row].location
//
//
//            return cell
//        //Add other cases here
//        default:
//            return UITableViewCell()
//        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "techwkorder", for: indexPath) as! TechWorkOrderCell

                if nSelectedSegmentIndex == 0 {
                    cell.wktypTokenlab.text = "W073563"
                    cell.wktype.text = "AC repair"
                     cell.supervisorlab.text = "Vernon Pitman"
                    cell.dateandtimelab.text = "21 NOV, 2020(11:00AM - 3:00PM)"
                    cell.locationlab.text = "NO 64, Al Raqim Plaza, Dheira(16 kms)"
                }
                else {
                    cell.wktypTokenlab.text = "W073563"
                    cell.wktype.text = "AC repair"
                     cell.supervisorlab.text = "Vernon Pitman"
                    cell.dateandtimelab.text = "21 NOV, 2020(11:00AM - 3:00PM)"
                    cell.locationlab.text = "NO 64, Al Raqim Plaza, Dheira(16 kms)"
                }

                return cell;
            
        
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "workorderdetail", sender: self)
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "workorderdetail") as! SupervisorHomeVc
//
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func segmentValueChange(_ sender: WMSegment) {
//        print("selected index = \(sender.selectedSegmentIndex)")
//        switch sender.selectedSegmentIndex {
//        case 0:
//            tabView.alpha = 1
//            print("first item")
//        case 1:
//            tabView.alpha = 0
//            filterVieww.alpha = 0
//            print("second item")
//        case 2:
//            tabView.alpha = 0
//            filterVieww.alpha = 0
//            print("Third item")
//        default:
//            print("default item")
//        }
        
        if sender.selectedSegmentIndex == 0 {
              self.nSelectedSegmentIndex = 1
          }
          else {
              self.nSelectedSegmentIndex = 2
          }
          self.tabView.reloadData()
        
    }
    
    func downloadItems() {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {return}


        let request = NSMutableURLRequest(url: NSURL(string: urlpath ?? "https://appstudio.co/iOS/N_Imdaad_emp_retrieve.php")! as URL)
            request.httpMethod = "POST"
            let postString = "employee_id=\(emp_id)"
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
            if let worktype = jsonElement["worktype"] as? String,
               let worktypetoken = jsonElement["token"] as? String,
            let supervisor = jsonElement["supervisor_name"] as? String,
            let dateTime = jsonElement["date_time"] as? String,
            let location = jsonElement["location"] as? String
            {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            let datetime = formatter.date(from: "\(jsonElement["TaskDate"] as! String) 13:37:00 +0100")
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "E,d MMM"
            let datetostring = dateformatter.string(from: datetime!)
            print("datetime \(datetime) \(jsonElement["TaskDate"] as? String) \(datetostring)")
            
                wkorder.append(workorderData(worktypetoken: worktypetoken, Worktype: worktype, supervisor: supervisor, Datetime: dateTime, location: location))
                
                }
            }
        DispatchQueue.main.async(execute: { [self] () -> Void in
         
        })
        }
    

    

}
struct workorderData {
    var worktypetoken:String?
var Worktype:String
var supervisor:String?
var Datetime: String?
var location: String?

}

