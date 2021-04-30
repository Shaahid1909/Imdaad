//
//  SupervisorFieldCompletion.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 25/04/21.
//

import UIKit

class SupervisorFieldCompletion: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var fwkorder = [fworkorderData]()
    var femp_id: String?
    var urlpath:String?
//    var fieldcomplete = [ccount]()
    
    @IBOutlet weak var ftabView: UITableView!
    
    @IBOutlet weak var filterVieww: UIView!
    
    @IBOutlet weak var ftotalworkorders: UILabel!
    
    
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
      //  fccountdownloadItems()

        ftabView.reloadData()
        ftabView.delegate = self
        ftabView.dataSource = self
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 214
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        ftotalworkorders.text = "\(fwkorder.count)"
        return fwkorder.count
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fwkorder", for: indexPath) as! SupervisorFieldCompletionCell
              
   
              
        cell.fwktypTokenlab.text = fwkorder[indexPath.row].fworktypetoken
        cell.ftechnicianlab.text = fwkorder[indexPath.row].ftechnician
        cell.fwktype.text = fwkorder[indexPath.row].fworktypetoken
        cell.fdateandtimelab.text = fwkorder[indexPath.row].fDatetime
        cell.flocationlab.text = fwkorder[indexPath.row].flocation
 
           
                return cell
            
        
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "fieldcompletion", sender: self)
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "workorderdetail") as! SupervisorHomeVc
//
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "fieldcompletion" {
            if segue.destination is SupervisorFieldWorkorderdetail {
                    if let indexPath = ftabView.indexPathForSelectedRow {
                        UserDefaults.standard.set(fwkorder[indexPath.row].fworktypetoken, forKey: "token_id")
                      
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
                //the following insures none of the JsonElement values are nil through optional binding
            if jsonElement["status_token"] as! String == "Completed"{
            fwkorder.append(fworkorderData(fworktypetoken: jsonElement["work_type_token"] as? String,fWorktype: jsonElement["work_type"] as? String, ftechnician: jsonElement["technician_name"] as? String, fDatetime: jsonElement["date_time"] as? String, flocation: jsonElement["location"] as? String, fpriority: jsonElement["is_high_priority"] as? String, fworkorder: jsonElement["work_order_count"] as? String))
                
                
            }}
        DispatchQueue.main.async(execute: { [self] () -> Void in
            itemsDownloaded(items: stocks)
        })
        }
    
    func itemsDownloaded(items: NSArray) {
       
        self.ftabView.reloadData()
      }
    
}
struct fworkorderData {
var fworktypetoken:String?
var fWorktype:String?
var ftechnician:String?
var fDatetime: String?
var flocation: String?
var fpriority: String?
var fworkorder: String?

}



